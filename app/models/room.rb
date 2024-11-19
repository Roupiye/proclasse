# == Schema Information
#
# Table name: rooms
#
#  id           :uuid             not null, primary key
#  code         :string           not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  professor_id :uuid             not null
#
# Indexes
#
#  index_rooms_on_professor_id  (professor_id)
#
# Foreign Keys
#
#  fk_rails_...  (professor_id => professors.id)
#
class Room < ApplicationRecord
  belongs_to :professor
  has_many :room_requests
  has_many :students, -> { joins(:room_requests).where(room_requests: {accepted: true}) }, through: :room_requests

  validates :name, presence: true, length: { minimum: 3, maximum: 32}
  validates :code, presence: true, length: { minimum: 6, maximum: 6}
end
