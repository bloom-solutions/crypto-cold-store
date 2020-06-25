module Xmr
  module Addresses
    module Creation
      class GenAddress

        extend LightService::Action
        expects :monero_client
        promises :public_address

        executed do |c|
          c.public_address = c.monero_client::Wallet.make_integrated_address["integrated_address"]
        end

      end
    end
  end
end
