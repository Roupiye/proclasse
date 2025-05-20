class ProcessSubmissionJob < ApplicationJob
  include CableReady::Broadcaster
  delegate :render, to: :ApplicationController

  queue_as :default

  def perform(task_id:, student_id:, code:)
    submission = Submission.create!(task_id:, student_id:, code:)

    submission.task.challenge.tests.each do |test|
      correction = Correction.new(test:, submission:)

      correction.tap do |c|
        c.input = test.input
        c.expected_out = test.expected_out

        code_eval = Piston.exec(:python, input: test.input) { code }
        out = code_eval["run"]["stdout"]
        out = code_eval["run"]["stderr"] unless out.present?

        c.output = out
        c.passed = c.output.strip == c.expected_out.strip
      end

      correction.save!
    end

    cable_ready[ApplicationChannel]
      .prepend(
        selector: "#submissions-list",
        html: render(
          SubmissionCardComponent.new(submission, index: Submission.where(task: submission.task, student: submission.student).count - 1),
          layout: false
        )
      )
      .broadcast_to("test")
  end
end
