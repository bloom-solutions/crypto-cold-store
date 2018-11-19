module Btc
  class SyncBlocks

    extend LightService::Organizer

    def self.call(block_hashes)
      with(block_hashes: block_hashes).reduce(actions)
    end

    def self.actions
      [
        InitBitcoinerClient,
        SetBlocks,
        GetRemoteBlocks,
        iterate(:remote_blocks, [
          DeleteForkedBlock,
          SaveBlockInfo,
        ]),
        GetRemoteBlocksTxs,
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
