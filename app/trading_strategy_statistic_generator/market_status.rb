
module StrategyTester
  class MarketStatus < JSONConvertible
    attr_reader :date_time, :ask_price, :bid_price, :ask_volume, :bid_volume

    def initialize(date_time, ask_price, bid_price, ask_volume, bid_volume)
      @date_time = date_time
      @ask_price = ask_price
      @bid_price = bid_price
      @ask_volume = ask_volume
      @bid_volume = bid_volume
    end
  end
end