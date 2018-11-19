module Btc
  class EnqueueBlockHashesToSync

    extend LightService::Action
    expects :block_hashes
    SLICE = 5.freeze

    executed do |c|
      c.block_hashes.each_slice(SLICE) do |block_hashes|
        SyncBlocksJob.perform_async(block_hashes)
      end
    end

  end
end
