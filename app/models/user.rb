class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    validates :age , numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 120}
    validates :country, length: { maximum: 50 }
    validates :profile, length: { maximum: 300 }
    has_many :microposts
end
