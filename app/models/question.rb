class Question < ApplicationRecord
  belongs_to :level

  has_many :exam_questions
  has_many :answers
end
