module Btc
  class ProcessRemoteTxs

    extend LightService::Organizer
    extend LightService::Action
    expects :remote_txs

    def self.call(ctx)
      with(ctx).reduce(actions)
    end

    executed do |c|
      self.(c)
    end

    def self.actions
      iterate(:remote_txs, [
        GetRemoteTxOutputs,
        iterate(:remote_tx_outputs, [
          GetRemoteTxOutputAddresses,
          FindAddress,
          SaveTxInfo,
          NotifyTxReceipt,
        ])
      ])
    end

  end
end
