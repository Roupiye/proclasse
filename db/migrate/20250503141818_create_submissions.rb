class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions, id: :uuid do |t|
      t.references :task, null: false, foreign_key: true, type: :uuid
      t.references :student, null: false, foreign_key: true, type: :uuid
      t.string :code, null: false
      t.string :result

      t.timestamps
    end
  end
end
