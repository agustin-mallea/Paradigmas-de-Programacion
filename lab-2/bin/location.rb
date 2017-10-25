class Location

	attr_accessor :name, :x_coordinate, :y_coordinate

	# Sets a location from a hash.
	def self.from_hash(hash)
		l = Location.new()
		hash.each do |k,v|
			l.instance_variable_set("@#{k}", v.is_a?(Hash) ? Hash.new(v) : v)
			l.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})
			l.class.send(:define_method, "#{k}=", proc{|v| self.instance_variable_set("@#{k}", v)})
		end
		return l
	end
end
