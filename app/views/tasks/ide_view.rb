# frozen_string_literal: true

class Tasks::IdeView < ApplicationView
  attr_reader :task

  def initialize(task)
    @task = task
    @view_height = "height: calc(100vh - 68.25px);"
  end

  def view_template
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
      div(class: "tabs tabs-boxed bg-base-200/50 rounded-none") {
        a(class: "tab tab-active", data_tabs_target: "tab", data_action: "click->tabs#change") { "Descrição" }
        a(class: "tab", data_tabs_target: "tab", data_action: "click->tabs#change") { "Resultados" }
      }

      div(style: "height: calc(100% - 40px)", data_tabs_target: "panel") {
        render partial("challenges/problem", challenge: task.challenge)
      }
      div(style: "height: calc(100% - 40px)", data_tabs_target: "panel", class: "flex flex-col") {
        div(class: "flex-1"){
          results_panel
        }
        div(){
          Button(:secondary, class: "w-full rounded-none") { "Testar código" }
        }
      }
    }
  end

  def results_panel
    div(class: "p-2") {
      Card(
        :base_100,
        data_controller: "reveal",
        data_reveal_hidden_class: "hidden",
        class: "w-full shadow-md border border-black/10 rounded-md"
      ) { |card|
        card.body(class: "px-2 py-2") {
          card.title(class: "p-0 flex justify-between", data_controller: "collapse", data_collapse_collapsableid_value: "submission-1-data") {
            div {"Envio 1"}
            Button(:ghost, :sm, data_action: "click->collapse#toggle") { "<" }
          }
          div(id: "submission-1-data", class: "hidden border border-black/10 rounded p-2", data_controller: "collapse", data_collapse_collapsableid_value: "test-1-data") {
            div(class: "flex justify-between items-center") {
              div() { "Teste 1" }
              Button(:ghost, :sm, data_action: "click->collapse#toggle") { "<" }
            }

            div(id: "test-1-data", class: "hidden") {
              plain "ajkwbdwa"
            }
          }
        }
      }
    }
  end
end
