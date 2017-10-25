class Driver < ApplicationRecord
	has_many :trips, dependent: :destroy
	serialize :ratings
	belongs_to :position, :class_name => 'Location', required: false

	before_save { self.mail = mail.downcase }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates(:name, presence: true)
	validates :mail, presence: true, format: { with: VALID_EMAIL_REGEX},
		uniqueness: { case_sensitive: false }
	validates(:licence, presence: true)
	validates(:fare, presence: true)

	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

	# Adds a rating to the instance variable ratings.
	def add_rating(new_rating)
		new_rating = Integer(new_rating)
		ratings[new_rating] += 1
 	end

	# Reverses the ratings variable without its first element.
	def get_rating_count
		res = [ratings[5],ratings[4],ratings[3],ratings[2],ratings[1]]
		return res
	end

	# Gives the average rating for the driver.
	def get_rating
		total = 0
		acu = 0
		(1..5).each do |i|
			acu += i*ratings[i]
			total += ratings[i]
		end
		if total != 0
			return acu/total
		else
			return 0
		end
	end

	# Increments the driver's balance
	def collect(money)
		money = Float(money)
		self.balance += money
	end
	
end
