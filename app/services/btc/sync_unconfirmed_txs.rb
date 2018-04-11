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
        iterate(:tx_ids, [
          GetRemoteTx,
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
