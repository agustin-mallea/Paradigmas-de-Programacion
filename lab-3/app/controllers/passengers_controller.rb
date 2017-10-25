class PassengersController < ApplicationController

  def show
  	@passenger = Passenger.find(params[:mail])
  end

  def create
  	@passenger = Passenger.new(user_params)
    @passenger.balance = 0
    if @passenger.save
      log_in @passenger
     	redirect_to root_url
    else
      render 'register/new'
    end
  end

  private

    def user_params
      params.require(:passenger).permit(:name, :mail, :phone, :password,
        :password_confirmation)
    end

end
