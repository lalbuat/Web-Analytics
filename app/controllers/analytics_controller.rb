class AnalyticsController < ApplicationController
	
	def perDay
		if(session[:user_id]== nil)
			redirect_to home_url
		else

			@db = MongoConfig.connection.db('test')
			@logs = @db.collection('logs')
			@tracking_id = params[:tracking_id]
			@month = Time.now.strftime("%b")
			@months31 = ["Jan","Mar","May","Jul","Aug","Oct","Dec"]
			@year = Time.now.strftime("%Y").to_i


			csv_string = CSV.generate do |csv|
				csv << ["Time","Number of views"]
				
				if @month == "Feb"
					if @year % 4 == 0
						("1".."29").each do |date|
							@date = date.rjust(2,'0')
							@views = @logs.find({month:@month,date:@date,tracking_id:@tracking_id}).count()
							csv << [date+"-"+@month,@views]
						end
					else
						("1".."28").each do |date|
							@date = date.rjust(2,'0')
							@views = @logs.find({month:@month,date:@date,tracking_id:@tracking_id}).count()
							csv << [date+"-"+@month,@views]
						end
					end

				elsif @months31.include?(@month) == true
					("1".."31").each do |date|
						@date = date.rjust(2,'0')
						@views = @logs.find({month:@month,date:@date,tracking_id:@tracking_id}).count()
						csv << [date+"-"+@month,@views]
					end
				else
					("1".."30").each do |date|
						@date = date.rjust(2,'0')
						@views = @logs.find({month:@month,date:@date,tracking_id:@tracking_id}).count()
						csv << [date+"-"+@month,@views]
					end
				end
			end

			send_data csv_string,:type=>'text/csv;charset=iso-8859-1;header=present',
								:disposition =>"attachment;filename=analytics.csv"
		end
	end
	
	def perMonth
		if(session[:user_id]== nil)
			redirect_to home_url
		else

			@db = MongoConfig.connection.db('test')
			@logs = @db.collection('logs')
			@tracking_id = params[:tracking_id]
			@year = Time.now.strftime("%Y")
			@months = ["Jan","Feb","Mar","Apl","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
	
			csv_string = CSV.generate do |csv|
				csv << ["Time","Number of views"]
				
				@months.each do |month|
					@month = month
					@views = @logs.find({year:@year,month:@month,tracking_id:@tracking_id}).count()
						csv << [@month,@views]
				end
			end

			send_data csv_string,:type=>'text/csv;charset=iso-8859-1;header=present',
								:disposition =>"attachment;filename=analytics.csv"
		end
	end
	
end