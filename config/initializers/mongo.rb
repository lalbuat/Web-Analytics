#MongoDB configuration class
class MongoConfig
	class << self
		attr_accessor :connection
	end
end

#Initialize MongoDB connection
connection = Mongo::Connection.new("localhost",27017)

#Save MongoDB connection in the MongoConfig class
MongoConfig.connection = connection