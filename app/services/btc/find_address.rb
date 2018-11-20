module Btc
  class FindAddress

    extend LightService::Action
    expects :remote_tx_output_addresses
    promises :address

    executed do |c|
      public_address = c.remote_tx_output_addresses.first
      c.address = Address.btc.find_by(address: public_address)
      c.skip_remaining! if c.address.nil?
    end

  end
end
