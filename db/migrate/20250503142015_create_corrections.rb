class CreateCorrections < ActiveRecord::Migration[8.0]
  def change
    create_table :corrections, id: :uuid do |t|
      t.references :submission, null: false, foreign_key: true, type: :uuid
      t.references :test, null: false, foreign_key: true, type: :uuid
      t.string :input, null: false
      t.string :expected_out, null: false
      t.string :output, null: false
      t.boolean :passed, null: false, default: false

      t.timestamps
    end
  end
end
