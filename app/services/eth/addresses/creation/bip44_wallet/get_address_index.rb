module Eth
  module Addresses
    module Creation
      module Bip44Wallet
        class GetAddressIndex

          extend LightService::Action
          promises :address_index

          executed do |c|
            c.address_index = ::Address.eth.count
          end

        end
      end
    end
  end
end
