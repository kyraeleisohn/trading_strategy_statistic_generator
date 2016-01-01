
module StrategyTester
  class SummaryConverter
    def get_as_statistic summary
      StrategyStatistic.new(
        summary.profit,
        get_profitability(summary),
        summary.trade_count,
        get_average_loss(summary),
        get_average_win(summary),
        summary.maximum_loss,
        summary.maximum_win,
        get_buy_percentage(summary),
        summary.buy_trade_win_count,
        summary.sell_trade_win_count,
        get_average_trade_length(summary),
        summary.one_minute_trade_count,
        summary.one_minute_trade_profit,
        get_one_minute_trade_win_percentage(summary)
      )
    end

    private

    def get_one_minute_trade_win_percentage summary
      Math.percentage(summary.one_minute_trade_wins, summary.one_minute_trade_count)
    end

    def get_buy_percentage summary
      Math.percentage(summary.buy_trade_count, summary.trade_count)
    end

    def get_average_win summary
      Math.percentage(summary.win_profit, summary.winning_trades)
    end

    def get_average_loss summary
      Math.percentage(summary.loss_profit, summary.losing_trades)
    end

    def get_profitability summary
      Math.percentage(summary.winning_trades, summary.trade_count)
    end

    def get_average_trade_length summary
      if summary.trade_count.equal? 0 then
        return 0
      end
      summary.sum_trade_length / summary.trade_count
    end
  end
end