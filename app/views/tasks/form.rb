# frozen_string_literal: true

class Tasks::Form < ApplicationView
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::FormWith

  attr_reader :task

  def initialize(task)
    @task = task

    if task.persisted?
      @action_verb = "Editar"
    else
      @action_verb = "Criar"
    end
  end

  def view_template
    div(class: "pb-2") {
      div(class: "flex justify-between items-center") {
        div(class: "flex items-center") {
          h1(class: "text-4xl font-bold leading-normal") { "#{@action_verb} Tarefa" }
        }
        div(class: "flex") {
          link_to("Cancelar", :back, class: "btn btn-error mr-2")
          label(class: "btn btn-primary", for: "submit") { @action_verb }
        }
      }

      form_with(model: task, builder: ProclasseFormBuilder) { |form|
        form_control(form, :due_date, type: :date_field, label: "Data entrega") do |block|
          block.call
          p(class: "mt-1 opacity-70") {
            "O horário de entrega sempre vai ser as 23:59"
          }
        end
        form_control(form, :challenge_id, type: :hidden_field)

        form.submit '', class: 'btn btn-primary hidden', id: "submit"
      }
    }
  end
end
