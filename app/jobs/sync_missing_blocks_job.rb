class SyncMissingBlocksJob < ApplicationJob

  def perform(coin)
    SyncMissingBlocks.(coin)
  end

end
