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
        ProcessRemoteTxs,
        DeleteDroppedUnconfirmedTxs,
      ]
    end

  end
end
