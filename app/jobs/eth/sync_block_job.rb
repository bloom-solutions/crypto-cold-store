module Eth
  class SyncBlockJob < ApplicationJob

    sidekiq_options unique: :until_executed, queue: "eth"

    def perform(block_height)
      SyncBlock.(block_height)
    end

  end
end
