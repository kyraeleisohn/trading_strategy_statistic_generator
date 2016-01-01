module StrategyTester
  class StrategyStatisticDao < MongoDao
    def write statistic
      @collection.insert_one statistic.to_hash
    end
  end
end