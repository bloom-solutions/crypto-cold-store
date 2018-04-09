module Btc
  class SyncBlock

    extend LightService::Organizer

    def self.call(block_index)
      with(block_index: block_index).reduce(actions)
    end

    def self.actions
      [
        InitBitcoinerClient,
        GetBlockHash,
        GetRemoteBlock,
        SaveBlockInfo,
        GetRemoteTxs,
        iterate(:remote_txs, [
          GetRemoteTxOutputs,
          iterate(:remote_tx_outputs, [
            FindAddress,
            SaveTxInfo,
            NotifyTxReceipt,
          ])
        ])
      ]
    end

  end
end
