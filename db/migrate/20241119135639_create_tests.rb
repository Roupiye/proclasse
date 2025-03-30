class CreateTests < ActiveRecord::Migration[8.0]
  def change
    create_table :tests, id: :uuid do |t|
      t.string :expected_out, null: false
      t.string :input, null: false
      t.boolean :hidden, null: false, default: false
      t.boolean :disabled, null: false, default: false
      t.belongs_to :challenge, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
