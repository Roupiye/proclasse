# frozen_string_literal: true

class Challenges::NewView < ApplicationView
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::FormWith

  attr_reader :challenge

  def initialize(challenge)
    @challenge = challenge
  end

  def view_template
    render Challenges::Form.new(challenge)
  end
end
