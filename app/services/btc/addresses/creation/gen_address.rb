module Btc
  module Addresses
    module Creation
      class GenAddress

        extend LightService::Action
        expects :address_index, :master_public_key, :signatures_required
        promises :public_address

        executed do |c|
          generator = Btc::AddressGenerator.new(
            xpub: c.master_public_key,
            signatures_required: c.signatures_required,
          )
          c.public_address = generator.address(c.address_index)
        end

      end
    end
  end
end
