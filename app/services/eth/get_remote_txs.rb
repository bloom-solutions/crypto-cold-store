module Eth
  class GetRemoteTxs

    extend LightService::Action
    expects :remote_block
    promises :remote_txs

    executed do |c|
      c.remote_txs = c.remote_block["transactions"]
    end

  end
end
