class UsersController < ApplicationController
	
	def userRegistration
	end

	def saveUser
		@firstname = params[:user][:first_name]
		@lastname = params[:user][:last_name]
		@password = params[:user][:password]
		@email = params[:user][:email]	
		@passwd = Digest::SHA2.hexdigest(@password)
		@userid = SecureRandom.hex(5)

		@db = MongoConfig.connection.db('test')
		@users = @db.collection('users')
	

		if	@users.find({email:@email}).count() == 0
			
			@users.insert({ 
				firstname:@firstname,
				lastname:@lastname,
				user_id:@userid,
				password:@passwd,
				email:@email})
			flash[:registered] = "You are successfully registered."
		else
			flash[:exist] = "Email Id already exist"
			redirect_to userReg_url
		end
	end

	def login
		@email = params[:user][:email]
		@password = params[:user][:password]
		@passwd = Digest::SHA2.hexdigest(@password)

		@db = MongoConfig.connection.db('test')
		@users = @db.collection('users')


		if @users.find({email:@email,password:@passwd}).count() == 0
			flash[:invalid]= "Your email id or password is Incorrect"
			redirect_to home_url
		else
			session[:user_id]= @users.find({email:@email}).to_a[0]["user_id"]
			redirect_to :action=>'home'
		end
	end	

	def home
		if(session[:user_id])
			@userid = session[:user_id]
			@db = MongoConfig.connection.db('test')
			@websites = @db.collection('websites')
			@websites =	@websites.find({user_id:@userid})

			@users = @db.collection('users')
			@username = @users.find({user_id:@userid}).to_a[0]["firstname"]
			@dataPerDayUrl = "//localhost:3000/analytics/perDay/"
			@dataPerMonthUrl = "//localhost:3000/analytics/perMonth/"
		else
			redirect_to :action=>'login'
		end
	end

	def logout
		session[:user_id]=nil
		redirect_to home_url
	end

	def removeUser
		if(params[:user])
			@email = params[:user][:email]
			@password = params[:user][:password]
			@db = MongoConfig.connection.db('test')
			@users = @db.collection('users')
			@passwd = Digest::SHA2.hexdigest(@password)
			
			if @users.find({email:@email,password:@passwd}).count() == 0
				flash[:notfound] = "User not found"
				redirect_to deactivate_url
			else
				@users.remove({email:@email,password:@passwd})
				flash[:found] = "Your account has been deactivated"
				session[:user_id] = nil
				redirect_to deactivate_url
			end
		end
	end

	def websiteRegistration
		if(!session[:user_id]) 
			redirect_to :action=>'login'
		end

		if (params[:website] != nil)
				@url = params[:website][:url]
				@websitename = params[:website][:name]
				@userid = session[:user_id]
				@regdate = Time.now.strftime("%d/%m/%Y %H:%M")

				@db = MongoConfig.connection.db('test')
				@websites = @db.collection('websites')
				@tracking_id = SecureRandom.hex(2)

				if @websites.find({website_url:@url}).count == 0	
				    @websites.insert({
							website_url:@url,
							website_name:@websitename,
							user_id:@userid,
							registration_date:@regdate,
							tracking_id:@tracking_id
							})
				    flash[:successful] = @url+" successfully regestered."
				    redirect_to userhome_url
				else
					flash[:failed] = "#{@url}"+" already exist."
					redirect_to webadd_url
				end
	
		end    
	end

end