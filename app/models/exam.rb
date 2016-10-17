class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  has_many :exam_questions
end
