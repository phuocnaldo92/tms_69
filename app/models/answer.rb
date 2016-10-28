class Answer < ApplicationRecord
  belongs_to :question
  has_many :exam_questions, dependent: :destroy, through: :exam_answers
  has_many :exam_answers, dependent: :destroy

  scope :correct, ->{where is_correct: true}
end
