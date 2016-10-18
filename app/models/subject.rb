class Subject < ApplicationRecord
  has_many :exams
  has_many :levels
  has_many :suggest_questions
end
