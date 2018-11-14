class SyncMissingBlocksJob < ApplicationJob

  sidekiq_options unique: :until_and_while_executing, on_conflict: :log

  def perform(coin)
    SyncMissingBlocks.(coin)
  end

end
