module Btc
  class CheckTxs

    extend LightService::Organizer

    def self.call
      reduce(actions)
    end

    def self.actions
      [
        InitBitcoinerClient,
        SetBlocks,
        GetCurrentBlock,
        GetBlocksToSync,
        GetBlocksHashes,
        EnqueueBlockHashesToSync,
      ]
    end

  end
end
