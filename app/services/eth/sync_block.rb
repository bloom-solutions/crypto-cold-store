module Eth
  class SyncBlock

    extend LightService::Organizer

    def self.call(block_index)
      with(block_index: block_index).reduce(actions)
    end

    def self.actions
      [
        InitEthereumClient,
        GetCurrentBlock,
        GetRemoteBlock,
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
