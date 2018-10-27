class SyncUnconfirmedTxsJob < ApplicationJob

  sidekiq_options unique: :until_executed, on_conflict: :log

  def perform(coin)
    coin.classify.constantize.const_get("SyncUnconfirmedTxs").()
  end

end
