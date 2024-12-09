# frozen_string_literal: true

class Challenges::TestsFields < ApplicationView
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::FormWith

  attr_reader :form

  def initialize(form)
    @form = form
  end

  def view_template
    div(class: "border rounded shadow-sm p-4 mt-10 border-black/10 relative"){
      div(class: "border rounded p-2 border-black/10 absolute flex right-2 -top-5 bg-base-100 items-center"){
        form.label(:hidden, class: "mr-2")
        form.check_box([:hidden], {})

        button(type: "button", data_action: "nested-form#remove", class: "btn btn-error btn-sm py-0 ml-2") { "Remover" }
      }
      form_control(form, :input)
      form_control(form, :expected_out)
    }
  end
end
