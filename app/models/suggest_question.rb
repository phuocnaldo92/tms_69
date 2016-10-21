class SuggestQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  has_many :suggest_answers, dependent: :destroy

  scope :alphabet, ->{order :content}
  enum status: {not_confirm: 0, confirmed: 1, rejected: 2}
  enum answer_type: {single_choice: 0, multi_choice: 1, text: 2}

  accepts_nested_attributes_for :suggest_answers, allow_destroy: true
  after_create :set_default_status

  validates :content, presence: true
  validates_associated :suggest_answers
  validate :validate_suggest_answers

  private
  def validate_suggest_answers
    s_a = suggest_answers
    unless self.text?
      if s_a.size <= Settings.minimum_suggest_answer
        errors.add :suggest_answers, I18n.t("questions.errors.must_more_one")
      end
      if s_a.reject{|suggest_answer| !suggest_answer.is_correct?}
          .count == Settings.reject_suggest_answer
        errors.add :suggest_answers, I18n
          .t("questions.errors.must_has_correct_answer")
      end
    end
  end

  def set_default_status
    if user.admin?
      self.confirmed!
    else
      self.not_confirm!
    end
  end
end
