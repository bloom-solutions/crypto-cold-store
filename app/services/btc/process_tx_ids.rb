module Btc
  class ProcessTxIds

    extend LightService::Organizer
    extend LightService::Action
    expects :tx_ids
    SLICE = 100.freeze

    def self.call(ctx)
      ctx.tx_ids.each_slice(SLICE) do |tx_ids|
        with(tx_ids: tx_ids).reduce(actions)
      end
      ctx
    end

    def self.actions
      [
        InitBitcoinerClient,
        GetRemoteTxsFromTxIds,
        ProcessRemoteTxs,
      ]
    end

  end
end
