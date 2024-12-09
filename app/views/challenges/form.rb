class Challenges::Form < ApplicationForm
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::RichTextArea

  def initialize(instance)
    super(instance)

    if instance.persisted?
      @action_verb = "Editar"
    else
      @action_verb = "Novo"
    end

  end

  def view_template(&)
    div(data: { controller: 'nested-form', nested_form_wrapper_selector_value: '.nested-form-wrapper' }) {
      div(class: "flex justify-between items-center") {
        div(class: "flex items-center") {
          h1(class: "text-4xl font-bold leading-normal") { "#{@action_verb} Desafio" }
        }
        div(class: "flex") {
          link_to("Cancelar", :back, class: "btn btn-error mr-2")
          submit(@action_verb, class: "btn btn-primary")
        }
      }

      error_messages

      labeled(
        field(:title).input(
          required: true,
          autofocus: true
        ),
        "Título"
      )

      # GAMBIS
        labeled(
          field(:problem).input(required: true),
          "Problema"
        ) {
          div(class: "bg-white p-2 border border-black/20 rounded shadow-sm") {
            rich_text_area :challenge, :problem
          }
        }

      labeled(
        field(:difficulty).select(
          *Challenge.difficulties.map{|k,v|[k,k]},
          required: true
        ),
        "Dificuldade"
      )

      # row field(:output).input
      template_tag(data_nested_form_target: "template") do
        div(class: "nested-form-wrapper", data_new_record: true) {
          namespace(:tests_attributes) do |test|
            render test.field(:input).input
            render test.field(:_destroy).input(type: :hidden)
          end
          button(type: "button", data_action: "nested-form#remove") {
            "Remove todo"
          }
        }
      end

      div(data_nested_form_target: "target")
      button(type: "button", data_action: "nested-form#add") { "Novo teste" }
    }
  end
end
