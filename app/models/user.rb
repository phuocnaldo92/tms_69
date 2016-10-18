class User < ApplicationRecord
  has_many :exams
  has_many :suggest_questions
end
