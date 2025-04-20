# frozen_string_literal: true

class Tasks::IdeView < ApplicationView
  def view_template
    div(class: "flex w-full", style: "height: calc(100vh - 68.25px);", data_controller: "resize") {
      div(class: "bg-blue-600 min-w-40", data_resize_target: "panelL") {
        plain "a"
      }

      div(class: "relative bg-red-600 flex-1 w-40", data_resize_target: "panelR") {
        div(
          class: "absolute top-0 bottom-0 cursor-col-resize bg-yellow-500 w-[10px]",
          data_resize_target: "gutter",
          data_action: "mousedown->resize#resize"
        )
        div(class: "pl-[10px]") {
          div(data_controller: "editor", style: "height: 100%")
        }
      }
    }
  end
end
