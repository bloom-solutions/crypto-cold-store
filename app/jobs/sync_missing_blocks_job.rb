class SyncMissingBlocksJob < ApplicationJob

  sidekiq_options unique: :until_executed

  def perform(coin)
    SyncMissingBlocks.(coin)
  end

end
