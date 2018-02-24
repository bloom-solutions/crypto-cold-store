module Addresses
  module Btc
    module Creation
      class FindUnusedAddress

        extend LightService::Action
        expects :electrum_client
        promises :public_address

        executed do |c|
          loop do
            c.public_address = create_new_address(c.electrum_client)
            break unless Address.btc.exists?(address: c.public_address)
          end
        end

        private

        def self.create_new_address(electrum_client)
          ElectrumCreateNewAddress.(electrum_client: electrum_client)
        end

      end
    end
  end
end
