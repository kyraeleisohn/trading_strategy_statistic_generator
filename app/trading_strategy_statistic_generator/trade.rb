
module StrategyTester
  class Trade < JSONConvertible
    attr_reader :opening_state, :closing_state

    def initialize opening_state
      @id = SecureRandom.uuid
      @opening_state = opening_state
    end

    def set_closing_state closing_state
      @closing_state = closing_state

      self
    end

    def is_buy
      false
    end

    def is_sell
      false
    end

    def hash
      @id.hash
    end
  end
end