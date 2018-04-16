class CheckTxsJob < ApplicationJob

  def perform(coin)
    coin.classify.constantize.const_get("CheckTxs").()
  end

end
