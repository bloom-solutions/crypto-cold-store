module Btc
  class SyncBlockJob < ApplicationJob

    sidekiq_options unique: :until_and_while_executing, queue: "btc"

    def perform(block_height)
      SyncBlock.(block_height)
    end

  end
end
