
module StrategyTester
  class Math
    def self.percentage(value, maximum_value)
      (maximum_value.equal? 0) ? 0 : (value.to_f / maximum_value.to_f)
    end
  end
end