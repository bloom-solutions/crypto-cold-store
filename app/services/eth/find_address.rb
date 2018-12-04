module Eth
  class FindAddress

    extend LightService::Action
    expects :remote_tx
    promises :address

    executed do |c|
      c.address = PgCircuit.run_on_context(c) do
        ::Address.eth.find_by(address: c.remote_tx["to"])
      end
      c.skip_remaining! if c.address.nil?
    end

  end
end
