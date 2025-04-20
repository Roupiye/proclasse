# == Schema Information
#
# Table name: tasks
#
#  id           :uuid             not null, primary key
#  due_date     :date
#  published_at :date
#  weight       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Task < ApplicationRecord
  validates :due_date, presence: true
  validates :weight, presence: true
end
