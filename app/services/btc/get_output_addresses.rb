module Btc
  class GetOutputAddresses

    extend LightService::Organizer
    extend LightService::Action
    expects :remote_txs
    promises :output_addresses

    def self.call(ctx)
      ctx[:output_addresses] = []
      with(ctx).reduce(actions)
    end

    def self.actions
      [
        iterate(:remote_txs, [
          GetRemoteTxOutputs,
          iterate(:remote_tx_outputs, [
            GetRemoteTxOutputAddresses,
            AppendOutputAddress,
          ])
        ])
      ]
    end

  end
end
