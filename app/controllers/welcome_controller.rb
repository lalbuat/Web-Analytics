class WelcomeController < ApplicationController
	
	def index	
		if(session[:user_id])
			redirect_to userhome_url
		end
	end
	
end