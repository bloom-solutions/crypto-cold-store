module Btc
  class FindAddress

    extend LightService::Action
    expects :remote_tx, :remote_tx_output
    promises :address

    SUPPORTED_SCRIPT_PUB_KEY_TYPES = %w(pubkeyhash scripthash)

    executed do |c|
      script_pub_key = c.remote_tx_output["scriptPubKey"]
      if SUPPORTED_SCRIPT_PUB_KEY_TYPES.include?(script_pub_key["type"])
        public_address = script_pub_key["addresses"].first
        c.address = Address.btc.find_by(address: public_address)
        c.skip_remaining! if c.address.nil?
      else
        c.address = nil
        c.skip_remaining!
      end
    end

  end
end
