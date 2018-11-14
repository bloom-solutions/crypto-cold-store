class SyncUnconfirmedTxsJob < ApplicationJob

  sidekiq_options unique: :until_and_while_executing, on_conflict: :log

  def perform(coin)
    coin.classify.constantize.const_get("SyncUnconfirmedTxs").()
  end

end
