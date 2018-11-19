module Btc
  class ProcessRemoteTxs

    extend LightService::Organizer
    extend LightService::Action
    expects :remote_txs

    executed do |c|
      with(c).reduce(actions)
    end

    def self.actions
      [
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
