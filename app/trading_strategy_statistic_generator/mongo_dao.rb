
module StrategyTester
  class MongoDao
    def initialize(host, database, collection)
      client = Mongo::Client.new([host], :database => database)
      @collection = client[collection]
    end
  end
end