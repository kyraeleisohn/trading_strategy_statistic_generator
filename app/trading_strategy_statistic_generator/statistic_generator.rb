
module StrategyTester
  class StatisticGenerator
    def initialize(closed_trade_dao, summary_converter, strategy_statistic_dao)
      @closed_trade_dao = closed_trade_dao
      @summary_converter = summary_converter
      @strategy_statistic_dao = strategy_statistic_dao
    end

    def run
      summary = ClosedTradeSummary.new
      @closed_trade_dao.each do |closed_trade|
        summary.add closed_trade
      end
      statistic = @summary_converter.get_as_statistic summary
      @strategy_statistic_dao.write statistic
    end
  end
end