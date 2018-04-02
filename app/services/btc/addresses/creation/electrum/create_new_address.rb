module Btc
  module Addresses
    module Creation
      module Electrum
        class CreateNewAddress

          def self.call(electrum_client:)
            electrum_client.create_new_address
          end

        end
      end
    end
  end
end
