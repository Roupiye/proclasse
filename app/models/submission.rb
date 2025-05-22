# == Schema Information
#
# Table name: submissions
#
#  id         :uuid             not null, primary key
#  code       :string           not null
#  result     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :uuid             not null
#  task_id    :uuid             not null
#
# Indexes
#
#  index_submissions_on_student_id  (student_id)
#  index_submissions_on_task_id     (task_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#  fk_rails_...  (task_id => tasks.id)
#
class Submission < ApplicationRecord
  belongs_to :task
  belongs_to :student

  enum :result, {
    success: "success",
    fail: "fail",
    pending: "pending"
  }, default: :pending

  has_many :corrections

  def passed?
    corrections.map{_1.passed}.all?(true)
  end
end
