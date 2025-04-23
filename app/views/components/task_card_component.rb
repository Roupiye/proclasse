# frozen_string_literal: true

class TaskCardComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo

  attr_reader :task

  def initialize(task)
    @task = task
  end

  def view_template
    Card(
      :base_100,
      class: "flex flex-row items-center justify-between mt-4 w-full shadow-md border border-black/10 px-4 py-2",
    ) { |card|
      p {
        plain task.challenge.title
        plain " "
        plain task.due_date.to_s
      }
      link_to("Mostrar", task_path(task))
    }
  end
end
