# == Schema Information
#
# Table name: tasks
#
#  id           :uuid             not null, primary key
#  due_date     :date             not null
#  published_at :date
#  weight       :float            not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  challenge_id :uuid             not null
#
# Indexes
#
#  index_tasks_on_challenge_id  (challenge_id)
#
# Foreign Keys
#
#  fk_rails_...  (challenge_id => challenges.id)
#
class Task < ApplicationRecord
  belongs_to :challenge

  validates :due_date, presence: true
  validates :weight, presence: true
  validates :challenge_id, presence: true
  validate :challenge_exists

  private

  def challenge_exists
    unless Challenge.exists?(challenge_id)
      errors.add(:challenge_id, "does not exist")
    end
  end
end
