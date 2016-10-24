class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :answer_type
      t.text :content
      t.references :level, foreign_key: true

      t.timestamps
    end
  end
end
