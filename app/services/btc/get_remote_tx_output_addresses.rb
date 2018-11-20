module Btc
  class GetRemoteTxOutputAddresses

    extend LightService::Action
    expects :remote_tx, :remote_tx_output
    promises :remote_tx_output_addresses

    SUPPORTED_SCRIPT_PUB_KEY_TYPES = %w(pubkeyhash scripthash)

    executed do |c|
      script_pub_key = c.remote_tx_output["scriptPubKey"]
      if SUPPORTED_SCRIPT_PUB_KEY_TYPES.include?(script_pub_key["type"])
        c.remote_tx_output_addresses = script_pub_key["addresses"]
      else
        c.remote_tx_output_addresses = []
        c.skip_remaining!
      end
    end

  end
end
