class RegisterController < ApplicationController
  def new
  	@passenger = Passenger.new
  	@driver = Driver.new
  end
end
