module Btc
  class SyncUnconfirmedTxs

    extend LightService::Organizer

    def self.call
      reduce(actions)
    end

    def self.actions
      [
        InitBitcoinerClient,
        GetRawMempoolTxIds,
        GetRemoteTxsFromTxIds,
        iterate(:remote_txs, [
          GetRemoteTxOutputs,
          iterate(:remote_tx_outputs, [
            FindAddress,
            SaveTxInfo,
            NotifyTxReceipt,
          ])
        ]),
        DeleteDroppedUnconfirmedTxs,
      ]
    end

  end
end
