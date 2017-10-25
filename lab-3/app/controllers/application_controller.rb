class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper

	APP_NAME = "Awesome app"

	def show
		if logged_in?

			if params[:user_id] != nil
				@user = Driver.find_by id: params[:user_id]
			else
				@user = current_user
			end

			render 'profile/show'
		else
			redirect_to root_url
		end
	end
end
