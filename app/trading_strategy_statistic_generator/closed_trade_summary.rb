
module StrategyTester
  class ClosedTradeSummary
    attr_reader(
      :profit,
      :trade_count,
      :winning_trades,
      :losing_trades,
      :win_profit,
      :loss_profit,
      :maximum_loss,
      :maximum_win,
      :buy_trade_count,
      :sell_trade_count,
      :buy_trade_win_count,
      :sell_trade_win_count,
      :sum_trade_length,
      :one_minute_trade_count,
      :one_minute_trade_profit,
      :one_minute_trade_wins,
    )
    def initialize
      @profit = 0
      @trade_count = 0
      @winning_trades = 0
      @losing_trades = 0
      @win_profit = 0
      @loss_profit = 0
      @maximum_loss = 0
      @maximum_win = 0
      @buy_trade_count = 0
      @sell_trade_count = 0
      @buy_trade_win_count = 0
      @sell_trade_win_count = 0
      @sum_trade_length = 0
      @one_minute_trade_count = 0
      @one_minute_trade_profit = 0
      @one_minute_trade_wins = 0
    end

    def add closed_trade
      profit = get_profit closed_trade

      add_profit profit
      add_profitability profit
      add_loss_or_win profit
      calculate_max_win_or_loss profit

      add_buy_or_sell_count closed_trade

      add_buy_or_sell_win_count(closed_trade, profit)
      add_trade_length(closed_trade, profit)

      @trade_count +=1
    end

    private

    def get_profit closed_trade
      price_difference = closed_trade.closing_state.ask_price.to_f - closed_trade.opening_state.ask_price.to_f

      closed_trade.is_buy ? price_difference : (-1 * price_difference)
    end

    def add_profit profit
      @profit += profit
    end

    def add_profitability profit
      if is_win profit
        @winning_trades += 1
      else
        @losing_trades += 1
      end
    end

    def add_loss_or_win profit
      if is_win profit
        @win_profit += profit
      else
        @loss_profit += profit
      end
    end

    def calculate_max_win_or_loss profit
      if is_win(profit) && (profit > @maximum_win)
        @maximum_win = profit
      elsif profit < @maximum_loss
        @maximum_loss = profit
      end
    end

    def add_buy_or_sell_count closed_trade
      if closed_trade.is_buy
        @buy_trade_count += 1
      else
        @sell_trade_count += 1
      end
    end

    def add_buy_or_sell_win_count(closed_trade, profit)
      unless is_win profit
        return
      end

      if closed_trade.is_buy
        @buy_trade_win_count += 1
      else
        @sell_trade_win_count += 1
      end
    end

    def add_trade_length(closed_trade, profit)
      trade_length = (
        (closed_trade.opening_state.date_time - closed_trade.closing_state.date_time) * 24 * 60 * 60
      ).to_i

      @sum_trade_length += trade_length

      if trade_length < 60
        @one_minute_trade_count += 1
        @one_minute_trade_profit += profit
        if is_win profit
          @one_minute_trade_wins += 1
        end
      end
    end

    def is_win profit
      profit > 0
    end
  end
end