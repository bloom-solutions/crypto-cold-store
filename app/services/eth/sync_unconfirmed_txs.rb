module Eth
  class SyncUnconfirmedTxs

    extend LightService::Organizer

    def self.call
      reduce(actions)
    end

    def self.actions
      [
        InitEthereumClient,
        GetPendingTxs,
        iterate(:remote_txs, [
          FindAddress,
          SaveTxInfo,
          NotifyTxReceipt,
        ]),
        DeleteDroppedUnconfirmedTxs,
      ]
    end

  end
end
