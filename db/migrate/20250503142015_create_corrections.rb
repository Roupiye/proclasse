class CreateCorrections < ActiveRecord::Migration[8.0]
  def change
    create_table :corrections, id: :uuid do |t|
      t.references :submission, null: false, foreign_key: true, type: :uuid
      t.references :test, null: false, foreign_key: true, type: :uuid
      t.string :input
      t.string :expected_output
      t.string :output

      t.timestamps
    end
  end
end
