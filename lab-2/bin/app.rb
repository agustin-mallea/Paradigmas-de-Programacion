require 'sinatra'
require 'sinatra/content_for'
require './bin/controller'
require "./bin/user"
require "./bin/trip"

# TODO Fill with your app name.
APP_NAME = "Awesome app"

# Sinatra configurations
enable :sessions

set :port, 8090
set :static, true
set :public_folder, "static"
set :views, "views"

set :session_secret, 'secret ' + APP_NAME

# Returns the name of the currently logged user
def get_username
	# TODO return the username of the logged in user, or nil if there is none.
	if session[:user_id].nil?
		return nil
	else
		aux = AppController.instance.users_by_id[session[:user_id]]
		if aux.nil?
			return nil
		else
			username = aux.get_username
		end
	end
	return username
end

get '/' do
	erb :index, :layout => :layout, :locals => {
		:app_title => APP_NAME,
		:username => get_username,
		:locations => AppController.instance.location_names
	}
end

get '/register' do
	erb :register, :layout => :layout, :locals => {
		:app_title => APP_NAME,
		:username => get_username
	}
end

get '/logout' do
	session.clear
	redirect '/'
end

# Registers a passenger. If the user email already exists, it returns code 400.
# Returns a redirection url.
# This handler will be called from a javascript code that, in case a sucess
# code is returned, will redirect to the redicrection url.
# The params keys are:
#   :name (str) name selected by the user
#   :email (str) email selected by the user. Must be unique in the app.
#   :phone (str) phone number selected by the user.
post '/register_passenger' do
    # TODO Register user
  	# TODO Store the user information in the session
  	# TODO consider case the user already exists returning code 400
  	name = params[:name]
  	mail = params[:email]
  	phone = params[:phone]

  	valid_mail = true

  	if AppController.instance.passengers.key? (mail) or AppController.instance.drivers.key? (mail)
  		valid_mail = false
  	end

  	if valid_mail
  		session[:user_id] = AppController.instance.register_passenger(name, mail, phone)
    	'/'  # In case everythin is ok, we return the redirection url
    else
    	halt 400
    end
end

# Registers a driver. If the user email already exists, it returns code 400.
# Returns a redirection url.
# This handler will be called from a javascript code that, in case a sucess
# code is returned, will redirect to the redicrection url.
# The params keys are:
#   :name (str) name selected by the user
#   :email (str) email selected by the user. Must be unique in the app.
#   :phone (str) phone number selected by the user.
#   :licence (str) the licence number selected by the user.
#   :fare (number) the fare by km selected by the user.
post '/register_driver' do
  	# TODO Register user
  	# TODO Store the user information in the session
  	# TODO consider case the user already exists returning code 400
  	name = params[:name]
  	mail = params[:email]
  	phone = params[:phone]
  	licence = params[:licence]
  	fare = params[:fare]

  	valid_mail = true

  	if AppController.instance.drivers.key? (mail) or AppController.instance.passengers.key? (mail)
  		valid_mail = false
  	end

  	if valid_mail
  		session[:user_id] = AppController.instance.register_driver(name, mail, phone, licence, fare)
	    '/'  # In case everythin is ok, we return the redirection url
	else
		halt 400
	end
end

get '/login' do
	erb :login, :layout => :layout, :locals => {
		:app_title => APP_NAME,
		:username => get_username
	}
end

# Logs in a new user.
# This handler will be called from a javascript code that, in case a sucess
# code is returned, will redirect to the redicrection url.
# The params keys are:
#   :email (str) The user email
#   :user_type (str) Indicates if the user is loging in as "passenger" or
#   "driver". Those are the only two possible values.
post '/login' do
	email = params[:email]
	user_type = params[:user_type]
	is_valid = AppController.instance.is_valid(user_type, email)
  	# TODO Store the new user in the current session
  	# TODO handle the case where the user does not exists returnin code 400
  	if is_valid
	  	# Successful case

	  	if user_type == "passenger"
	  		u = AppController.instance.passengers[email]
	  	elsif user_type == "driver"
	  		u = AppController.instance.drivers[email]
	  	end

	  	session[:user_id] = u.get_id

	  	redirect_url = nil
	  	if !session[:go_back].nil?
	  		# Before calling login, the app stored a spepecific page to go back
	  		params = session[:go_back][:params]
	  		redirect_url = session[:go_back][:url]
	  		session[:go_back_to] = nil
	  		redirect_url = redirect_url + '?' + URI.encode_www_form(params)
	  	else
	  		redirect_url = '/'
	  	end
	  	redirect_url
    else
      halt 400
    end
end

# Returns the list_trip page. The params keys are:
#   :origin (str) the name of the origin location (optional)
#   :destination (str) the name of the origin location (optional)
get '/list_trips' do
	erb :list_trips, :layout => :layout, :locals => {
		:app_title => APP_NAME,
		:username => get_username,
		:locations => AppController.instance.location_names,
		:destination => params[:destination],
		:origin => params[:origin]
	}
end

# Renders an html with a table of available trips. For now, these trips are
# created randomly. The param keys are:
#   :origin (str) the name of the origin location
#   :destination (str) the name of the origin location
post '/available_trips' do
	# TODO create an store random_trips.
	origin = params[:origin]
	destination = params[:destination]
	random_trips = AppController.instance.random_trips(origin, destination)

	if random_trips.nil?
		random_trips = []
	end
	session[:trips] = random_trips

	erb :available_trips, :layout => false, :locals => {
		:trips => random_trips,
	}
end

# Confirms the trip selected by the user and redirects to a page that waits
# for payment. The param keys are:
#   :trip_number the position of the selected trip in the tabled rendered by
#   the handler /available_trips
get '/finish_trip' do

    if session[:user_id].nil?
        # The user is not logged in, redirect to login page and save parameters
        session[:go_back] = {:url => '/finish_trip', :params => {
            :trip_number => params[:trip_number]}}
            redirect '/login'
        else
        # TODO select the correct trip
        index = params[:trip_number]
        if index.nil?
            redirect '/list_trips'
        end
        index = Integer(index)

        trip = session[:trips][index]

        if trip.driver.get_id == session[:user_id]
            redirect '/list_trips'
        end

        trip.passenger = AppController.instance.users_by_id[session[:user_id]]

        if session[:arrived].nil?
            trip.position = trip.origin
        end

        if session[:arrived] == false
            old_distance = trip.get_distance_to_destination
            old_position = trip.position
            trip.position = AppController.instance.gps
            if trip.get_distance_to_destination >= old_distance
                trip.position = old_position
            end
        end

        drivername = trip.driver.get_username
        position = trip.position.name
        distance = trip.get_distance_to_destination

        arrived = false
        if distance == 0
            arrived = true
        end

        session[:arrived] = arrived

        session[:trip] = trip

        erb :finish_trip, :layout => :layout, :locals => {
            :app_title => APP_NAME,
            :username => get_username,
    # TODO fill the :driver_name value
    :driver_name => drivername,
    :position => position,
    :distance => distance,
    :arrived => arrived,
}
end
end

# Saves the payment and the possible rating of the user. The param keys are:
#   :rating (int) The scoring of the driver for this trip.
post '/pay_trip' do
  	# TODO Pay the trip and Update driver rating
  	# TODO Delete information from previous trip

  	trip = session[:trip]
  	rating = params[:rating]
  	if rating.nil?
  		redirect back
  	end

  	if params[:type] == 'credit'
  		trip.driver.add_rating(rating)
  		session[:rating] = nil
  		redirect '/pay_trip_miles'
  	end

   trip.passenger.pay(trip.get_cost)
   trip.passenger.add_miles(trip.get_distance)

   trip.driver.add_rating(rating)
   trip.driver.collect(trip.get_cost)

   AppController.instance.users_by_id[trip.driver.get_id] = trip.driver
   AppController.instance.users_by_id[trip.passenger.get_id] = trip.passenger
   AppController.instance.drivers[trip.driver.get_mail] = trip.driver

   if trip.passenger.class.name.split('::').last == 'Driver'
    AppController.instance.drivers[trip.passenger.get_mail] = trip.passenger
else
    AppController.instance.passengers[trip.passenger.get_mail] = trip.passenger
end

AppController.instance.save_users
session[:trip] = nil
session[:rating] = nil
session[:arrived] = nil
redirect '/'
end

get '/pay_trip_miles' do

	trip = session[:trip]
 drivername = trip.driver.get_username
 user_miles = trip.passenger.get_miles
 trip_cost = trip.get_cost

 erb :pay_trip_miles, :layout => :layout, :locals => {
  :app_title => APP_NAME,
  :username => get_username,
      		# TODO fill the :driver_name value
      		:driver_name => drivername,
      		:user_miles => user_miles,
      		:trip_cost => trip_cost,
        }

    end

    post '/pay_trip_miles' do

       trip = session[:trip]
       miles = params[:miles].to_f

       if miles > trip.passenger.get_miles or miles > trip.get_cost or miles < 0
          redirect '/pay_trip_miles'
      end

      trip.passenger.pay_miles(miles)
      trip.passenger.pay(trip.get_cost - miles)

      trip.driver.collect(trip.get_cost)

      AppController.instance.users_by_id[trip.driver.get_id] = trip.driver
      AppController.instance.users_by_id[trip.passenger.get_id] = trip.passenger
      AppController.instance.drivers[trip.driver.get_mail] = trip.driver

      if trip.passenger.class.name.split('::').last == 'Driver'
        AppController.instance.drivers[trip.passenger.get_mail] = trip.passenger
    else
        AppController.instance.passengers[trip.passenger.get_mail] = trip.passenger
    end

    AppController.instance.save_users
    session[:trip] = nil
    session[:arrived] = nil
    redirect '/'

end



# Shows the user's profile page. Only if the user is looking at his/hers own
# profile page the balance will be shown.
# The param keys are:
#   :user_id (str or nil) The user's identifier. In no value is passed, the
#   profile of the logged user will be shown.
get '/profile' do
  	# TODO get the user reference
  	id = params[:user_id]
  	viewall = false

  	if id.nil?
  		id = session[:user_id]
  		viewall = true
  	end

  	id = Integer(id)

  	user = AppController.instance.users_by_id[id]

  	erb :profile, :layout => :layout, :locals => {
  		:app_title => APP_NAME,
  		:username => get_username,
	    # TODO fill the :user and :is_driver and :view_all values
	    # :view_all is a boolean indicating if the user's balance can be displayed.
	    :user => user,
	    :is_driver => user.is_driver,
	    :view_all => viewall,
	}
end
