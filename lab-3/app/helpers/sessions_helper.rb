module SessionsHelper
	# Logs in the given user.
	def log_in(user)
		session[:mail] = user.mail
	end

  # Returns the current logged-in user (if any).
  def current_user
  	if session[:mail].nil?
  		@current_user = nil
  	else
  		aux = Passenger.find_by(mail: session[:mail])
  		if aux.nil?
  			aux = Driver.find_by(mail: session[:mail])
  		end
  		if aux.nil?
  			@current_user = nil
  		else
  			@current_user = aux
  		end
  	end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:mail)
    @current_user = nil
  end

  def get_current_user_name
  	if @current_user.nil?
  		return nil
  	else
  		return @current_user.name
  	end
  end

end
