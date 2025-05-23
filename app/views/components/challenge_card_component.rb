# frozen_string_literal: true

class ChallengeCardComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::ImageTag

  attr_reader :challenge

  def initialize(challenge)
    @challenge = challenge
  end

  def view_template
    link_to(challenge_path(challenge)) {
      Card(
        :base_100,
        class: "flex flex-row items-center justify-start mt-4 w-full shadow-md border border-black/10 px-4 py-2",
      ) { |card|
        image_tag "/#{challenge.difficulty}.png", width: "50px"
        p(class: "ml-2") { challenge.title }
        if challenge.user == Current.user
          p(class: "ml-auto") { "Próprio" }
        end
      }
    }
  end
end
