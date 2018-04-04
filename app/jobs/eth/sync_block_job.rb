module Eth
  class SyncBlockJob < ApplicationJob

    def perform(block_index)
      SyncBlock.(block_index)
    end

  end
end
