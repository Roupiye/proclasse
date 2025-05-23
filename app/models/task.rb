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
class Task < ApplicationRecord
  belongs_to :challenge
  belongs_to :room
  has_many :submissions

  validates :due_date, presence: true
  validates :challenge_id, presence: true
  validate :challenge_exists
  validate :due_date_in_valid_range

  private

  def challenge_exists
    unless Challenge.exists?(challenge_id)
      errors.add(:challenge_id, "does not exist")
    end
  end

  def due_date_in_valid_range
    return if due_date.blank?

    if due_date <= Date.current
      errors.add(:due_date, "deve estar no futuro")
    elsif due_date > 1.year.from_now.to_date
      errors.add(:due_date, "deve estar dentro de 1 ano")
    end
  end
end
