# == Schema Information
#
# Table name: challenges
#
#  id         :uuid             not null, primary key
#  difficulty :integer
#  problem    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#
# Indexes
#
#  index_challenges_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Challenge < ApplicationRecord
  belongs_to :user
  has_many :tests
  accepts_nested_attributes_for :tests, reject_if: :all_blank, allow_destroy: true

  has_rich_text :problem

  enum :difficulty, [:easy, :itermediate, :hard], default: :easy

  validates :title, presence: true, length: { minimum: 6}
  validates :difficulty, presence: true
  validates :problem, presence: true, length: { minimum: 60}
end
