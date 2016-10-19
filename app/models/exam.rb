class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  delegate :name, :to => :subject, :allow_nil => true

  has_many :exam_questions

  enum status: {start: 0, testing: 1, uncheck: 2, checked: 3}

  after_create :set_default

  scope :newest, ->{order created_at: :desc}

  def set_default
    self.start!
    self.update score: Settings.exams.default_score,
      spent_time: Settings.exams.default_spent_time
  end
end
