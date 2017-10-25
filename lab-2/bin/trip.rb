class Trip

	attr_accessor :origin, :destination, :position, :driver, :passenger, :cost

	def initialize(origin, destination, driver, position)
		@origin = origin
		@destination = destination
		@driver = driver
		@position = position
	end

	# => Gives the total cost of the trip.

	def get_cost
		total = get_distance * driver.get_fare.to_f
		return total
	end

	# => Gives de distance between origin and destination

	def get_distance
		miles = (@origin.x_coordinate - @destination.x_coordinate).abs + (@origin.y_coordinate - @destination.y_coordinate).abs
		return miles.to_f
	end

	def get_distance_to_passenger
		miles = (@origin.x_coordinate - @position.x_coordinate).abs + (@origin.y_coordinate - @position.y_coordinate).abs
		return miles.to_f
	end

	def get_distance_to_destination
		miles = (@position.x_coordinate - @destination.x_coordinate).abs + (@position.y_coordinate - @destination.y_coordinate).abs
		return miles.to_f
	end
end
