# This file contains the application controller that keeps track of the objects
# and manages the interactions inbetween themselves and with the user.

require "json"
require "singleton"
require "./bin/location"
require "./bin/user"
require "./bin/trip"
# What is a singleton? Check Singleton Design Pattern on Google

USER_DATABASE_FILENAME = "users.json"
LOCATIONS_DATABASE_FILENAME = "locations.json"

class AppController
	include Singleton

	# Attribute to save the name of the user logged in.
	attr_reader :drivers, :passengers, :locations, :users_by_id

	def initialize
		# Attributes to store the registered passengers and drivers while the
		# app is running.
		# To load/save to json, this hashes can't have symbols.
		# Attribute indexed by user_id
		@users_by_id = {}

		# Attributes indexed by email
		@passengers = {}
		@drivers = {}

		# Attribute to store the possible locations
		@locations = {}

		load_locations
		load_users
	end

	# Registers a new passenger. Returns the id of the new user.
	def register_passenger(name, email, phone)

 		# TODO  to keep track of the new user registered
 		passenger = Passenger.new(name, email, phone)
 		@passengers[passenger.get_mail] = passenger
 		@users_by_id[passenger.get_id] = passenger
 		save_users
		# TODO return the passenger id
		return passenger.get_id
	end

	# Registers a new driver. Returns the id of the new user.
	def register_driver(name, email, phone, licence, fare)
		# TODO  keep track of the new user registered
		driver = Driver.new(name, email, phone, licence, fare)
		@drivers[driver.get_mail] = driver
		@users_by_id[driver.get_id] = driver
		save_users
		# TODO return the driver id
		return driver.get_id
	end

	# Creates a fake list of trips
	def random_trips(origin, destination)
		if origin == destination
			return nil
		end
		trips = []
		# TODO (optional) consider the case when the locations are incorrect
		origin = @locations[origin]
		destination = @locations[destination]
		position = gps
		

		@drivers.each_value { |driver| trips.push(
    	# TODO create a new random trip
    	Trip.new(origin, destination, driver, position)
    	)}

		return trips
	end

	def location_names
		return @locations.keys
	end

	#
	def gps

		lkeys = @locations.keys
		random = rand(lkeys.length)
		position = @locations[lkeys[random]]

		return position
	end

	# Checks if the email is registered.
	def is_valid(usertype, email)
		if usertype == "passenger"
			if @passengers.key? (email)
				return true
			end
		elsif usertype == "driver"
			if @drivers.key? (email)
				return true
			end
		end
		return false
	end

	# Saves the users in the hashes @drivers and @passengers
	# in a json file.
	# Each user instance must have a to_hash method.
	def save_users
		data_hash = []
		# TODO fill the values of data_hash with hashes for all the users, ordered
    	# by id.
    	@users_by_id.each { |key, value|
    		hash = value.to_hash
    		data_hash.push(hash)
    	}
    	file = File.open(USER_DATABASE_FILENAME, 'w')
    	file.write(data_hash.to_json)
    	file.close
    end

    private


    def load_locations
    	begin
    		file_content = File.read(LOCATIONS_DATABASE_FILENAME)
    		data_hash = JSON.parse(file_content)
    	rescue Errno::ENOENT
            # The file does not exists
            data_hash = []
        end
    	# TODO use the values in data_hash to fill the @locations list.
    	data_hash.each { |h|
    		location = Location.new()
    		location = Location.from_hash(h)
    		@locations[location.name] = location
    	}
    end


	# Reads the json file USER_DATABASE_FILENAME and loads the saved users into
	# @drivers and @passengers
	def load_users
		begin
			file_content = File.read(USER_DATABASE_FILENAME)
			data_hash = JSON.parse(file_content)
		rescue Errno::ENOENT
            # The file does not exists
            data_hash = []
            save_users
        end
    	# TODO save the drivers and passengers in data_hash into the @drivers
    	# and @passenger attributes
    	data_hash.each { |h|

    		user = User.from_hash(h)
    		if user.is_driver
    			@drivers[user.get_mail] = user
    		else
    			@passengers[user.get_mail] = user
    		end

    		@users_by_id[user.get_id] = user

    	}
    end

    public :save_users, :is_valid, :location_names, :random_trips, :register_passenger, :register_driver
    private :load_locations, :load_users
end