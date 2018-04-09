module Btc
  class GetRemoteTxOutputs

    extend LightService::Action
    expects :remote_tx
    promises :remote_tx_outputs

    executed do |c|
      c.remote_tx_outputs = c.remote_tx["vout"]
    end

  end
end
