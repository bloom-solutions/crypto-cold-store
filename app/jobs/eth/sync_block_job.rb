module Eth
  class SyncBlockJob < ApplicationJob

    def perform(block_height)
      SyncBlock.(block_height)
    end

  end
end
