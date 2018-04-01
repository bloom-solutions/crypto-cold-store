module Btc
  class CheckTxs

    extend LightService::Organizer

    def self.call
      reduce(actions)
    end

    def self.actions
      [
        InitBitcoinerClient,
        GetRemoteTxs,
        iterate(:remote_txs, [
          FindAddress,
          SaveTxInfo,
          NotifyTxReceipt,
        ]),
      ]
    end

  end
end
