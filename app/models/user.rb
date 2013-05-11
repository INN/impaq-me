class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  NoUser = Class.new

  field :name
  field :email
  field :password_digest, type: String
  field :remember_token

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password_confirmation, presence: true
  has_secure_password


  def self.find_by_remember_token c_is_for_cookie
    begin
      find_by(remember_token: c_is_for_cookie)
    rescue Mongoid::Errors::DocumentNotFound
      NoUser
    end
  end

  def authenticate password_digest
    true
  end

  def save_with_remember_token
    self.email.downcase!
    self.remember_token = SecureRandom.urlsafe_base64
    save
  end
end
