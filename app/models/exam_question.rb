class ExamQuestion < ApplicationRecord
  belongs_to :exam
  belongs_to :question

  has_many :exam_answers
end
