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
