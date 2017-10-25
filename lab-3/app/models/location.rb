class Location < ApplicationRecord
	has_many :trips
	has_many :drivers
end
