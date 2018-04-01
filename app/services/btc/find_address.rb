module Btc
  class FindAddress

    extend LightService::Action
    expects :remote_tx
    promises :address

    executed do |c|
      c.address = Address.btc.find_by(address: c.remote_tx["address"])
      c.skip_remaining! if c.address.nil?
    end

  end
end
