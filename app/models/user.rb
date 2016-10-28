class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  has_many :exams, dependent: :destroy
  has_many :suggest_questions, dependent: :destroy

  scope :newest, ->{order created_at: :desc}
  enum role: {user: 1, admin: 0}
  validates :name, presence: true, length: {maximum: 50}
  validates :chatwork_id, length: {maximum: 50}

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = "tranthaonguyen.dsher@gmail.com"
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.provider = auth.provider
      user.uid = auth.uid
      end
    end
  end
end
