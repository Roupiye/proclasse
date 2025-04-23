class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.date :published_at
      t.date :due_date, null: false
      t.belongs_to :room, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
