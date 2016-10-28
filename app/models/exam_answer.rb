class ExamAnswer < ApplicationRecord
  belongs_to :exam_question
  belongs_to :answer

  scope :correct, ->{where answers: {is_correct: true}}
end
