# frozen_string_literal: true

class Challenges::NewView < ApplicationView
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::FormWith

  attr_reader :challenge

  def initialize(challenge)
    @challenge = challenge

    if challenge.persisted?
      @action_verb = "Editar"
    else
      @action_verb = "Novo"
    end
  end

  def view_template
    div(data: { controller: 'nested-form', nested_form_wrapper_selector_value: '.nested-form-wrapper' }) {
      div(class: "flex justify-between items-center") {
        div(class: "flex items-center") {
          h1(class: "text-4xl font-bold leading-normal") { "#{@action_verb} Desafio" }
        }
        div(class: "flex") {
          link_to("Cancelar", :back, class: "btn btn-error mr-2")
          label(class: "btn btn-primary", for: "submit") { @action_verb }
        }
      }

      form_with(model: @challenge) { |form|
        form_control(form, :title)
        form_control(form, :difficulty, type: :select, args: [Challenge.difficulties.keys, {}])
        form_control(form, :problem) do
          div(class: "bg-white p-2 border border-black/20 rounded shadow-sm") {
            form.rich_text_area :problem
          }
        end


        template_tag(data_nested_form_target: "template") do
          div(class: "nested-form-wrapper", data_new_record: true) {
            form.fields_for :tests, Test.new, child_index: 'NEW_RECORD' do |test_fields|
              form_control(test_fields, :input)
              form_control(test_fields, :expected_out)
              form_control(test_fields, :hidden)
            end
            button(type: "button", data_action: "nested-form#remove") {
              "Remove todo"
            }
          }
        end

        div(data_nested_form_target: "target")
        button(type: "button", data_action: "nested-form#add") { "Novo teste" }

        form.submit '', class: 'btn btn-primary hidden', id: "submit"
      }
    }
  end
end
