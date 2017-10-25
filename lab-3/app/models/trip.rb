class Trip < ApplicationRecord
  belongs_to :driver, required: true
  belongs_to :origin, :class_name => 'Location', required: false
  belongs_to :destination, :class_name => 'Location', required: false

  def get_cost
		total = (origin.x_coordinate - destination.x_coordinate).abs + 
			(origin.y_coordinate - destination.y_coordinate).abs
		total = total.to_f * driver.fare.to_f
		return total
	end
	
end
