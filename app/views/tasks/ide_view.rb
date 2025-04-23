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
        # unsafe_raw(task.challenge.problem.to_trix_html)
        render partial("challenges/problem", challenge: task.challenge)
      }
      div(style: "height: calc(100% - 40px)", data_tabs_target: "panel", class: "flex flex-col") {
        div(class: "flex-1"){ plain "dwadwa" }
        div(){
          Button(:secondary, class: "w-full rounded-none") { "Testar código" }
        }
      }
    }
  end
end
