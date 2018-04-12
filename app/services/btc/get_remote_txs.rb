module Btc
  module GetRemoteTxs

    extend LightService::Action
    expects :remote_block
    promises :remote_txs

    executed do |c|
      c.remote_txs = c.remote_block["tx"] || []
    end

  end
end
