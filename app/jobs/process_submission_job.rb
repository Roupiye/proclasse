class ProcessSubmissionJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "lol"
  end
end
