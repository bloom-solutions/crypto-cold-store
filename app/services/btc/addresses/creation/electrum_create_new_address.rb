module Btc
  module Addresses
    module Creation
      class ElectrumCreateNewAddress

        def self.call(electrum_client:)
          electrum_client.create_new_address
        end

      end
    end
  end
end
