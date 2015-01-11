class TrackerController < ApplicationController
	def log
		@ip = request.remote_ip
		@tracking_id = params['tracking_id']
		@year = Time.now.strftime("%Y")
		@month = Time.now.strftime("%b")
		@date = Time.now.strftime("%d")


		@db = MongoConfig.connection.db('test')
		@logs = @db.collection('logs')

		@logs.insert({
			ip_address:@ip,
			tracking_id:@tracking_id,
			year:@year,
			month:@month,
			date:@date
			})
	end
end