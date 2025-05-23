# frozen_string_literal: true

class TaskCardComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::DistanceOfTimeInWords

  attr_reader :task, :completed

  def initialize(task, completed)
    @task = task
    @completed = completed
  end

  def view_template
    link_to(task.due_date < Time.now ? "#" : task_ide_path(task)) {
      Card(
        :base_100,
        class: "flex flex-col items-center justify-between mt-4 w-full #{color} shadow-md border border-black/10 px-4 py-2",
      ) { |card|
        p(class: "font-semibold") {
          Challenge.select(:title, :id).where(id: task.challenge_id).last.title
        }

        div(class: "text-center w-full border-t-[1px] border-t-black/10 mt-2 pt-2"){
          div(class:"tooltip", data_tip:"#{task.due_date}") {
            span {
              if task.due_date > Time.now
                distance_of_time_in_words(task.due_date, Time.now) + " para entregar"
              else
                "fechado á " + distance_of_time_in_words(Time.now, task.due_date)
              end
            }
          }
        }
      }
    }
  end

  def color
    if completed
      "bg-green-300/40"
    elsif task.due_date < Time.now
      "bg-red-300/40"
    else
      "bg-blue-100/90"
    end
  end
end
