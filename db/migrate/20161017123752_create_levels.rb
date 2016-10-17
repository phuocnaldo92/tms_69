class CreateLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :levels do |t|
      t.string :name
      t.integer :question_number
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
