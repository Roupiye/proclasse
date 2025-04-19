# frozen_string_literal: true

class Tasks::IdeView < ApplicationView
  def view_template
    div(
      data_controller: "resize",
      data_action: " mousemove@ window->resize#set mouseup@window->resize#stop",
      class: "relative"
    ) do
      whitespace
      nav(data_resize_target: "panel") do
        plain "aaaa"
      end
      div(
        data_action: " mousedown->resize#start",
        class:
          "absolute top-0 right-0 z-10 w-2 h-full bg-gray-500 cursor-ew-resize"
      ) {
      }
        plain "odwajoidajwdoiajwdoiawj"
    end


    div(class: "flex", style: "height: calc(100vh - 68.25px);") {
      div(class: "w-full bg-blue-600") {
        plain "a"
      }

      div(class: "w-full bg-red-600") {
        plain "b"
      }
    }
  end
end
