class Answer < ApplicationRecord
  belongs_to :question

  has_many :exam_answers
end
