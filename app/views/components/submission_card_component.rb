# frozen_string_literal: true

class SubmissionCardComponent < ApplicationComponent
  attr_reader :submission, :index

  def initialize(submission, index: 0)
    @submission = submission
    @index = index
  end

  def view_template
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
          div(class: "flex items-center") {
            div(class: "mr-2 badge badge-#{submission.passed? ? "primary" : "error"}") {}
            div {"Envio #{index + 1}"}
          }
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
        div(class: "flex items-center") {
          div(class: "mr-2 badge badge-#{correction.passed ? "primary" : "error"}") {}
          div() { "Teste #{index + 1} " }
        }
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
