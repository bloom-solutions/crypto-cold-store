module Btc
  class ProcessRemoteTxs

    extend LightService::Organizer
    extend LightService::Action
    expects :remote_txs

    def self.call(ctx)
      with(ctx).reduce(actions)
    end

    def self.actions
      [
        GetOutputAddresses,
        reduce_if(->(c) { Address.where(address: c.output_addresses).any? }, [
          iterate(:remote_txs, [
            GetRemoteTxOutputs,
            iterate(:remote_tx_outputs, [
              GetRemoteTxOutputAddresses,
              FindAddress,
              SaveTxInfo,
              NotifyTxReceipt,
            ])
          ])
        ]),
      ]
    end

  end
end
