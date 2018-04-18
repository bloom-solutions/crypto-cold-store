module Eth
  class SyncBlock

    extend LightService::Organizer

    def self.call(block_height)
      with(block_height: block_height).reduce(actions)
    end

    def self.actions
      [
        InitEthereumClient,
        SetBlocks,
        GetCurrentBlock,
        GetRemoteBlock,
        DeleteForkedBlock,
        SaveBlockInfo,
        GetRemoteTxs,
        iterate(:remote_txs, [
          FindAddress,
          SaveTxInfo,
          NotifyTxReceipt,
        ])
      ]
    end

  end
end
