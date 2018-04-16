class SyncUnconfirmedTxsJob < ApplicationJob

  sidekiq_options unique: :until_executed

  def perform(coin)
    coin.classify.constantize.const_get("SyncUnconfirmedTxs").()
  end

end
