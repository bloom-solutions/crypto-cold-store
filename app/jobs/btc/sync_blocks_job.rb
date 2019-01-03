module Btc
  class SyncBlocksJob < ApplicationJob

    sidekiq_options({
      unique: :until_executed,
      queue: "btc",
      lock_expiration: 2.minutes,
    })

    def perform(block_hashes)
      SyncBlocks.(block_hashes)
    end

  end
end
