class SuggestAnswer < ApplicationRecord
  belongs_to :suggest_question

  validates :content, presence: true
end
