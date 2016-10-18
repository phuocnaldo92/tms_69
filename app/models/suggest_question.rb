class SuggestQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  has_many :suggest_answers
end
