class TripsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def my_trips
    if !logged_in? or !current_user.has_attribute?(:licence)
      redirect_to login_url
    else
      driver = current_user
      @trips = Trip.where(driver_id: driver.id)
    end
  end

  def available_trips
    if !logged_in? or current_user.has_attribute?(:licence)
      redirect_to login_url
    else
      randomize_positions
      if params[:origin] == "" or params[:destination] == ""
        @trips = Trip.all
      else
        destination = Location.find_by name: params[:destination]
        origin = Location.find_by name: params[:origin]
        if Trip.where(origin_id: origin.id, destination_id: destination.id).exists?
          @trips = Trip.joins(:driver).where("position_id = ?",origin.id).where(
          origin_id: origin.id, destination_id: destination.id)
        else
          @trips = false
        end
      end
    end
  end

  def randomize_positions
    drivers = Driver.all
    drivers.each do |driver|
      random = Location.offset(rand(Location.count)).first
      if !driver.update_attribute(:position_id, random.id)
        puts driver.errors.full_messages
      end
    end
  end

  def create

    if params[:origin] == "" or params[:destination] == "" or 
      params[:origin] == params[:destination]
      redirect_back fallback_location: root_url
    else

      @destination = params[:destination]
      @origin = params[:origin]

      trip = Trip.new
      origen = Location.find_by name: @origin
      destino = Location.find_by name: @destination
      user = current_user

      if Trip.where(:origin_id => origen.id, :destination_id => destino.id,
        :driver_id => user.id).exists?
        redirect_back fallback_location: root_url
      else

        trip.origin_id = origen.id
        trip.destination_id = destino.id
        trip.driver_id = user.id
      end

      if trip.save
        redirect_to root_url
      else
        puts trip.errors.full_messages
      end
    end
  end

  def finish_trip
    if !logged_in?
      redirect_to login_url
    elsif params[:trip_number].nil?
        redirect_back fallback_location: root_url
    else
      trip = Trip.find_by id: params[:trip_number]
      @driver_name = trip.driver.name
      session[:trip_id] = params[:trip_number]
    end
  end

  def pay_trip
    if params[:rating].nil?
      redirect_back fallback_location: root_url
    else
      rating = params[:rating]
      trip = Trip.find_by id: session[:trip_id]
      if trip.nil?
        redirect_back fallback_location: root_url
      else
        driver = Driver.find(trip.driver_id)
        
        driver.add_rating(rating)

        # Intente usando driver.collect() pero no anda.
        driver.balance += trip.get_cost
      
        if driver.update_attribute(:ratings, driver.ratings)
          redirect_to root_url
        else
          puts driver.errors.full_messages
        end
      end
    end
  end

end
