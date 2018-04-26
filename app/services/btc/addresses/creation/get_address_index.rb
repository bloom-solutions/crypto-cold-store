module Btc
  module Addresses
    module Creation
      class GetAddressIndex

        extend LightService::Action
        promises :address_index

        executed do |c|
          c.address_index = Address.btc.count
        end

      end
    end
  end
end
