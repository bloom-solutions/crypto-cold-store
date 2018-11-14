module Eth
  class SyncBlockJob < ApplicationJob

    sidekiq_options unique: :until_and_while_executing, queue: "eth"

    def perform(block_height)
      SyncBlock.(block_height)
    end

  end
end
