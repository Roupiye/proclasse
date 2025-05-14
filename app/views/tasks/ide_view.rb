# frozen_string_literal: true

class Tasks::IdeView < ApplicationView
  include Phlex::Rails::Helpers::FormWith

  attr_reader :task, :submissions

  def initialize(task:, submissions:)
    @task = task
    @submissions = submissions
    @view_height = "height: calc(100vh - 68.25px);"
  end

  def view_template
    div(data_controller: "cable-from", data_cable_from_id_value: "test")

    div(class: "flex w-full", style: @view_height, data_controller: "resize") {
      div(class: "w-96", style: "#{@view_height} min-width: 215px", data_resize_target: "panelL") {
        left_panel
      }

      div(class: "relative flex-1 w-40", data_resize_target: "panelR") {
        div(
          class: "absolute top-0 bottom-0 cursor-col-resize bg-black w-[10px] opacity-50",
          data_resize_target: "gutter",
          data_action: "mousedown->resize#resize"
        )
        div(class: "pl-[10px]") {
          div(data_controller: "editor", style: "height: 100%")
        }
      }
    }
  end

  def left_panel
    div(class: "h-full", data: {controller: "tabs", tabs_active_tab_class: "tab-active"}) {
      div(class: "tabs tabs-boxed bg-base-200/50 rounded-none shadow-sm") {
        a(class: "tab tab-active", data_tabs_target: "tab", data_action: "click->tabs#change") { "Descrição" }
        a(class: "tab", data_tabs_target: "tab", data_action: "click->tabs#change") { "Resultados" }
      }

      div(style: "height: calc(100% - 40px)", data_tabs_target: "panel") {
        # render partial("challenges/problem", challenge: task.challenge)
        render "challenges/problem", challenge: task.challenge #, challenge: task.challenge)
      }
      div(style: "height: calc(100% - 40px)", data_tabs_target: "panel", class: "flex flex-col") {
        div(class: "flex-1 overflow-x-auto"){
          results_panel
        }
        div(){
          form_with(class: "m-0", url: task_submit_path, remote: false) { |form|
            form.hidden_field(:task_id, value: task.id)
            form.hidden_field(:submission_code, value: "")
            Button(:secondary, class: "btn btn-secondary w-full rounded-none") { "Testar código" }
          }
        }
      }
    }
  end

  def results_panel
    div(id: "submissions-list", class: "p-2") {
      submissions.each_with_index do |submission, index|
        result(submission, index:)
      end
    }
  end

  def result(submission, index: 0)
    Card(
      :base_100,
      data_controller: "reveal",
      data_reveal_hidden_class: "hidden",
      class: "w-full shadow-md border border-black/10 rounded-md mb-3"
    ) { |card|
      card.body(class: "px-2 py-2") {
        card.title(
          class: "p-0 flex justify-between",
          data_controller: "collapse",
          data_collapse_collapsableid_value: "submission-#{submission.id}-data"
        ) {
          div {"Envio #{index + 1}"}
          Button(:ghost, :sm, data_action: "click->collapse#toggle") { "<" }
        }
        div(id: "submission-#{submission.id}-data", class: "hidden") {
          submission.corrections.each_with_index do |correction, index|
            test_result(correction, index:)
          end
        }
      }
    }
  end

  def test_result(correction, index: 0)
    div(
      class: "border border-black/10 rounded p-2 mb-2",
      data_controller: "collapse",
      data_collapse_collapsableid_value: "test-#{correction.id}-data"
    ) {
      div(class: "flex justify-between items-center") {
        div() { "Teste #{index + 1}" }
        Button(:ghost, :sm, data_action: "click->collapse#toggle") { "<" }
      }

      div(id: "test-#{correction.id}-data", class: "hidden") {
        div(class: "divider my-0")

        div(class: "grid grid-cols-1 grid-rows-3 gap-2") {
          correction_attr_view(correction, :input)
          correction_attr_view(correction, :expected_out)
          correction_attr_view(correction, :output)
        }
      }
    }
  end

  def correction_attr_view(correction, attr)
    div {
      span(class: "text-sm font-medium") { attr.to_s.camelize }
      pre(class: "w-full overflow-x-auto py-3 px-3 bg-black/20 rounded-sm") {correction.send(attr)}
    }
  end
end
