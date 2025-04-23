# == Schema Information
#
# Table name: tasks
#
#  id           :uuid             not null, primary key
#  due_date     :date             not null
#  published_at :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  challenge_id :uuid             not null
#  room_id      :uuid             not null
#
# Indexes
#
#  index_tasks_on_challenge_id  (challenge_id)
#  index_tasks_on_room_id       (room_id)
#
# Foreign Keys
#
#  fk_rails_...  (challenge_id => challenges.id)
#  fk_rails_...  (room_id => rooms.id)
#
require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
