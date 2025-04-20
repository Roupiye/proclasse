# frozen_string_literal: true

class Tasks::NewView < ApplicationView
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::FormWith

  attr_reader :task

  def initialize(task)
    @task = task
  end

  def view_template
    render Tasks::Form.new(task)
  end
end
