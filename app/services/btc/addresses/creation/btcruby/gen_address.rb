module Btc
  module Addresses
    module Creation
      module Btcruby
        class GenAddress

          extend LightService::Action
          expects :keychain, :address_index
          promises :public_address

          executed do |c|
            c.public_address =
              c.keychain.derived_key(c.address_index).address.to_s
          end

        end
      end
    end
  end
end
