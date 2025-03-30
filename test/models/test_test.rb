# == Schema Information
#
# Table name: tests
#
#  id           :uuid             not null, primary key
#  disabled     :boolean          default(FALSE), not null
#  expected_out :string           not null
#  hidden       :boolean          default(FALSE), not null
#  input        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  challenge_id :uuid             not null
#
# Indexes
#
#  index_tests_on_challenge_id  (challenge_id)
#
# Foreign Keys
#
#  fk_rails_...  (challenge_id => challenges.id)
#
require "test_helper"

class TestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
