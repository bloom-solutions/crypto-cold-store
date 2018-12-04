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
        execute(->(ctx) { ctx[:output_addresses] = [] }),
        iterate(:remote_txs, [
          GetRemoteTxOutputs,
          iterate(:remote_tx_outputs, [
            GetRemoteTxOutputAddresses,
            AppendOutputAddress,
          ])
        ]),
        reduce_if(->(c) {
          PgCircuit.run_on_context(c) do
            Address.where(address: c[:output_addresses]).any?
          end
        }, [
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
