
module StrategyTester
  class StatisticGeneratorBuilder
    def get config
      closed_trade_dao = ClosedTradeDao.new(
        config['mongo']['trade_log']['host'],
        config['mongo']['trade_log']['database'],
        config['mongo']['trade_log']['collection']
      )
      summary_converter = SummaryConverter.new
      strategy_statistic_dao = StrategyStatisticDao.new(
        config['mongo']['strategy_statistic']['host'],
        config['mongo']['strategy_statistic']['database'],
        config['mongo']['strategy_statistic']['collection']
      )
      StatisticGenerator.new(
          closed_trade_dao,
          summary_converter,
          strategy_statistic_dao
      )
    end
  end
end