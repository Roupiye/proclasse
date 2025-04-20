class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.date :published_at
      t.date :due_date, null: false
      t.float :weight, null: false

      t.timestamps
    end
  end
end
