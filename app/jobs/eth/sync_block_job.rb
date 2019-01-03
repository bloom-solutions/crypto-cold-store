module Eth
  class SyncBlockJob < ApplicationJob

    sidekiq_options({
      unique: :until_executed,
      queue: "eth",
      lock_expiration: 2.minutes,
    })

    def perform(block_height)
      SyncBlock.(block_height)
    end

  end
end
