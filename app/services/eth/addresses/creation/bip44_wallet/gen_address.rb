module Eth
  module Addresses
    module Creation
      module Bip44Wallet
        class GenAddress

          extend LightService::Action
          expects :bip44_wallet, :address_index
          promises :public_address

          executed do |c|
            c.public_address =
              c.bip44_wallet.get_ethereum_address(c.address_index.to_s)
          end

        end
      end
    end
  end
end
