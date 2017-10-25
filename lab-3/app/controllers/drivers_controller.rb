class DriversController < ApplicationController
  

  def show
  	@driver = Driver.find(params[:mail])
  end

  def create
  	@driver = Driver.new(user_params)
    @driver.ratings = [nil,0,0,0,0,0]
    @driver.balance = 0
    @driver.position_id = (Location.offset(rand(Location.count)).first).id
    if @driver.save
      log_in @driver
      redirect_to root_url
    else
      render 'register/new'
    end
  end

  private

    def user_params
      params.require(:driver).permit(:name, :mail, :phone, :licence, :fare,
        :password, :password_confirmation)
    end
end
