class Subject < ApplicationRecord
  has_many :exams
  has_many :levels, dependent: :destroy
  has_many :suggest_questions, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}
  validates :duration, presence: true, numericality: {only_integer: true}

  scope :newest, ->{order created_at: :desc}
  scope :search, ->subject_name {where "name LIKE ?", "#%{subject_name}%"}
end
