module Eth
  class FindAddress

    extend LightService::Action
    expects :remote_tx
    promises :address

    executed do |c|
      c.address = ::Address.eth.find_by(address: c.remote_tx["to"])
      c.skip_remaining! if c.address.nil?
    end

  end
end
