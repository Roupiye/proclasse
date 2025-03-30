# == Schema Information
#
# Table name: users
#
#  id               :uuid             not null, primary key
#  context          :integer
#  email            :string           not null
#  name             :string           not null
#  password_digest  :string           not null
#  verified         :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  selected_room_id :uuid
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (selected_room_id => rooms.id)
#
class User < ApplicationRecord
  has_one :professor, required: false
  has_one :student, required: false
  belongs_to :selected_room, class_name: :Room, optional: true

  enum :context, [:student, :professor], default: :student

  has_secure_password

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end

  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end


  has_many :sessions, dependent: :destroy

  validates :name, presence: true, length: { minimum: 9, maximum: 32}
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, length: {maximum: 32}
  validates :password, allow_nil: true, length: { minimum: 6 }

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  after_create { register_as_student }

  def can_edit_challenge?(challenge)
    challenge.user_id == id &&
    professor?
  end

  def context_model
    student? ? student : professor
  end

  def toggle_context
    update!(context: student? ? "professor" : "student")
  end

  def register_as_teacher
    if professor.nil?
      Professor.create!(user: self)
      true
    else
      false
    end
  end

  def register_as_student
    if student.nil?
      Student.create!(user: self)
      true
    else
      false
    end
  end
end
