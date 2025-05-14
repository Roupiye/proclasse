# == Schema Information
#
# Table name: corrections
#
#  id            :uuid             not null, primary key
#  expected_out  :string           not null
#  input         :string           not null
#  output        :string           not null
#  passed        :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  submission_id :uuid             not null
#  test_id       :uuid             not null
#
# Indexes
#
#  index_corrections_on_submission_id  (submission_id)
#  index_corrections_on_test_id        (test_id)
#
# Foreign Keys
#
#  fk_rails_...  (submission_id => submissions.id)
#  fk_rails_...  (test_id => tests.id)
#
class Correction < ApplicationRecord
  belongs_to :submission
  belongs_to :test
end
