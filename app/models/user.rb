class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :exams
  has_many :suggest_questions, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
  enum role: {user: 1, admin: 0}
  validates :name, presence: true, length: {maximum: 50}
  validates :chatwork_id, presence: true, length: {maximum: 50}

  def check user
    user == current_user
  end
end
