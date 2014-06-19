class User < ActiveRecord::Base
  include ActiveModel::SecurePassword
  NoUser = Class.new

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_secure_password :validations => false
  validates_presence_of :password, :unless => -> { password_digest.present? }
  validates_presence_of :password_confirmation, :unless => -> { password_digest.present? }

  before_save { self.email.downcase! }
  before_create :create_remember_me_token, :unless => -> { remember_token.present? }

  def self.find_by_remember_token(c_is_for_cookie)
    find_by(remember_token: c_is_for_cookie) || NoUser
  end

private

  def create_remember_me_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
