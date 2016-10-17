class CreateExamAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :exam_answers do |t|
      t.text :content
      t.boolean :is_choice
      t.references :exam_question, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
