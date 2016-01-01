module StrategyTester
  class ClosedTradeDao < MongoDao
    def write trade
      @collection.insert_one trade.to_hash
    end

    def each
      @collection.find.each do |closed_trade|
        opening_state = get_market_status_from_hash closed_trade[:opening_state]
        closing_state = get_market_status_from_hash closed_trade[:closing_state]
        closed_trade_object = Trade.new opening_state
        closed_trade_object.set_closing_state closing_state

        yield closed_trade_object
      end
    end

    private

    def get_market_status_from_hash hash
      MarketStatus.new(
          get_date_time_as_object(hash[:date_time]),
          hash[:ask_price],
          hash[:bid_price],
          hash[:ask_volume],
          hash[:bid_volume],
      )
    end

    def get_date_time_as_object date_time_string
      Time.strptime(date_time_string, '%d.%m.%Y %H:%M:%S.%L')
    end
  end
end