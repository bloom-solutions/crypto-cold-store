class SyncMissingBlocksJob < ApplicationJob

  sidekiq_options unique: :until_executed, on_conflict: :log

  def perform(coin)
    SyncMissingBlocks.(coin)
  end

end
