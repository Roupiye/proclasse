# frozen_string_literal: true

class Tasks::IdeView < ApplicationView
  include Phlex::Rails::Helpers::FormWith

  attr_reader :task, :submissions

  def initialize(task:, submissions:)
    @task = task
    @submissions = submissions
    @view_height = "height: calc(100vh - 64px);"
  end

  def view_template
    div(data_controller: "cable-from", data_cable_from_id_value: "#{task.id}#{Current.user.student.id}")

    div(class: "flex w-full", style: @view_height, data_controller: "resize") {
      div(id: "ide-panel-l", class: "w-96", style: "#{@view_height} min-width: 215px", data_resize_target: "panelL") {
        left_panel
      }

      div(class: "relative flex-1 w-40", data_resize_target: "panelR") {
        div(
          id: "ide-gutter",
          class: "absolute top-0 bottom-0 cursor-col-resize bg-black w-[10px] opacity-50",
          data_resize_target: "gutter",
          data_action: "mousedown->resize#resize"
        )
        div(id: "ide-code", class: "pl-0 sm:pl-[10px]") {
          div(data_controller: "editor", style: "height: 100%")
        }
      }
    }

    dock
  end

  def left_panel
    div(class: "h-full", data: {controller: "tabs", tabs_active_tab_class: "tab-active"}) {
      div(class: "tabs tabs-boxed bg-base-200/50 rounded-none shadow-sm") {
        a(class: "tab tab-active", data_tabs_target: "tab", data_action: "click->tabs#change") { "Descrição" }
        a(class: "tab", data_tabs_target: "tab", data_action: "click->tabs#change") { "Resultados" }
      }

      div(style: "height: calc(100% - 40px)", data_tabs_target: "panel") {
        render partial("challenges/problem", challenge: task.challenge)
        # render "challenges/problem", challenge: task.challenge #, challenge: task.challenge)
      }
      div(style: "height: calc(100% - 40px)", data_tabs_target: "panel", class: "flex flex-col") {
        div(class: "flex-1 overflow-x-auto"){
          results_panel
        }
        div(){
          form_with(class: "m-0", url: task_submit_path, remote: false) { |form|
            form.hidden_field(:task_id, value: task.id)
            form.hidden_field(:submission_code, value: "")
            Button(:secondary, class: "hidden sm:block btn btn-secondary w-full rounded-none") { "Testar código" }
          }
        }
      }
    }
  end

  def dock
    div(
      id: "ide-dock",
      data_controller: "ide-dock",
      class: "dock bg-neutral text-neutral-content flex sm:hidden",
      data_action:"resize@window->ide-dock#watch"
    ) do
      button do
        div(class: "size-[1.2em]") { "C" }
        span(class: "dock-label") { "Voltar" }
      end
      button do
        div(class: "size-[1.2em]") { "C" }
        span(class: "dock-label") { "Descrição" }
      end
      button do
        div(class: "size-[1.2em]") { "C" }
        span(class: "dock-label") { "Resultados" }
      end
      button(class: "dock-active") do
        div(class: "size-[1.2em]") { "C" }
        span(class: "dock-label") { "Código" }
      end
      button do
        div(class: "size-[1.2em]") { "C" }
        span(class: "dock-label") { "Enviar" }
      end
    end
  end

  def results_panel
    div(id: "submissions-list", class: "p-2") {
      submissions.each_with_index do |submission, index|
        render SubmissionCardComponent.new(submission, index: submissions.size - (index + 1))
      end
    }
  end
end
