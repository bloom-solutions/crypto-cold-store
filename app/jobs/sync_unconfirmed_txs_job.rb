class SyncUnconfirmedTxsJob < ApplicationJob

  def perform(coin)
    coin.classify.constantize.const_get("SyncUnconfirmedTxs").()
  end

end
