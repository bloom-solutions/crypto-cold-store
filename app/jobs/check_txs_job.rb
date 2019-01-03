class CheckTxsJob < ApplicationJob

  sidekiq_options(
    unique: :until_executed,
    on_conflict: :log,
    lock_expiration: 2.minutes,
  )

  def perform(coin)
    coin.classify.constantize.const_get("CheckTxs").()
  end

end
