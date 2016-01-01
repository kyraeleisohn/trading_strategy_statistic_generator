PROJECT_ROOT_DIR = File.dirname(__FILE__)
$:.unshift File.expand_path(PROJECT_ROOT_DIR)

require 'yaml'
require 'mongo'
require 'securerandom'
require 'json'

module StrategyTester
  autoload :MarketStatus, 'trading_strategy_statistic_generator/market_status'
  autoload :TradeList, 'trading_strategy_statistic_generator/trade_list'
  autoload :Trade, 'trading_strategy_statistic_generator/trade'
  autoload :BuyTrade, 'trading_strategy_statistic_generator/buy_trade'
  autoload :SellTrade, 'trading_strategy_statistic_generator/sell_trade'
  autoload :MongoDao, 'trading_strategy_statistic_generator/mongo_dao'
  autoload :ClosedTradeDao, 'trading_strategy_statistic_generator/closed_trade_dao'
  autoload :JSONConvertible, 'trading_strategy_statistic_generator/json_convertible'
  autoload :StatisticGeneratorBuilder, 'trading_strategy_statistic_generator/statistic_generator_builder'
  autoload :StatisticGenerator, 'trading_strategy_statistic_generator/statistic_generator'
  autoload :StrategyStatisticDao, 'trading_strategy_statistic_generator/strategy_statistic_dao'
  autoload :SummaryConverter, 'trading_strategy_statistic_generator/summary_converter'
  autoload :ClosedTradeSummary, 'trading_strategy_statistic_generator/closed_trade_summary'
  autoload :StrategyStatistic, 'trading_strategy_statistic_generator/strategy_statistic'
  autoload :Math, 'trading_strategy_statistic_generator/math'

  class Application
    def initialize
      config = YAML.load_file(PROJECT_ROOT_DIR + '/trading_strategy_statistic_generator/config/config.yml')

      statistic_generator_builder = StatisticGeneratorBuilder.new
      @statistic_generator = statistic_generator_builder.get config
    end

    def run
      @statistic_generator.run
    end
  end
end

application = StrategyTester::Application.new
application.run