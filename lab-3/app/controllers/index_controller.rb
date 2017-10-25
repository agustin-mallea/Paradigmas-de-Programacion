class IndexController < ApplicationController

	#GET /index
	def index
		@app_title = APP_NAME,
		@username = get_current_user_name
		@locations = Location.all
		@trip = Trip.new
	end
end
