module Mongo
  class User
    include Mongoid::Document
    store_in collection: "users"
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

    before_save { self.email.downcase! }
    before_create { self.remember_token = SecureRandom.urlsafe_base64 }

    def self.find_by_remember_token c_is_for_cookie
      begin
        find_by(remember_token: c_is_for_cookie)
      rescue Mongoid::Errors::DocumentNotFound
        NoUser
      end
    end
  end
end
