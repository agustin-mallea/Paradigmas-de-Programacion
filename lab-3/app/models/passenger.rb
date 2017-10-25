class Passenger < ApplicationRecord

	before_save { self.mail = mail.downcase }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:name, presence: true)
	validates :mail, presence: true, format: { with: VALID_EMAIL_REGEX},
		uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
end
