class User

	@@globalid = 0

	# Transforms the object into a hash.
	def to_hash
		instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = instance_variable_get(var) }
	end

	# Makes either a driver or a passenger from a hash.
	def self.from_hash(hash)
		if hash.key? ('fare')
			u = Driver.new()
		else
			u = Passenger.new()
		end
		hash.each do |k,v|
			u.instance_variable_set("@#{k}", v.is_a?(Hash) ? Hash.new(v) : v)
			u.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})
			u.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})
		end
		return u
	end

	def is_driver
		if self.class.name.split('::').last == 'Driver'
			return true
		else
			return false
		end
	end

	# Decrements the users balance.
	def pay(money)
		@balance -= money
	end

	# => Accumulates miles in profile.
	def add_miles(miles)
		@miles += miles
	end

	# => Accumulates miles in profile.
	def pay_miles(miles)
		@miles -= miles
	end

	# Increments the class variable and assigns it to the instance id.
	def set_id
		@@globalid += 1
		@id = @@globalid
	end

	def get_username
		return @username
	end

	def get_mail
		return @mail
	end

	def get_id
		return @id
	end

	def get_phone
		return @phone
	end

	def get_balance
		return @balance
	end

	def get_miles
		return @miles
	end

	public :get_id, :set_id, :get_username, :get_mail, :to_hash, :get_phone, :get_balance, :get_miles
end


class Driver < User


	def initialize(username = nil, mail = nil, phone = nil, licence = nil, fare = nil)
		set_id
		@username = username
		@mail = mail
		@phone = phone
		@licence = licence
		@fare = fare
		@ratings = [nil,0,0,0,0,0]
		@balance = 0
		@miles = 0
	end

	# Adds a rating to the instance variable ratings.
	def add_rating(new_rating)
		new_rating = Integer(new_rating)
		@ratings[new_rating] += 1
	end

	# Reverses the ratings variable without its first element.
	def get_rating_count
		res = [@ratings[5],@ratings[4],@ratings[3],@ratings[2],@ratings[1]]
		return res
	end

	# Gives the total amount of ratings for the driver.
	def get_rating
		total = 0
		acu = 0
		(1..5).each do |i|
			acu += i*@ratings[i]
			total += @ratings[i]
		end
		if total != 0
			return acu/total
		else
			return 0
		end
	end

	# Increments the driver's balance
	def collect(money)
		@balance += money
	end

	def get_licence
		return @licence
	end

	def get_fare
		return @fare
	end

	public :get_rating_count, :get_rating, :add_rating, :collect, :get_licence, :get_fare

end

class Passenger < User

	def initialize(username = nil, mail = nil, phone = nil)
		set_id
		@username = username
		@mail = mail
		@phone = phone
		@balance = 0
		@miles = 0
	end

end
