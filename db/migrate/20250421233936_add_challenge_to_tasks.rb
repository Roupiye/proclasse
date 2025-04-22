class AddChallengeToTasks < ActiveRecord::Migration[8.0]
  def change
    add_reference :tasks, :challenge, foreign_key: true, type: :uuid, null: false
  end
end
