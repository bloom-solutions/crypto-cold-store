module Btc
  module Addresses
    module Creation
      class SaveAddress

        extend LightService::Action
        expects :public_address, :code
        promises :address

        executed do |c|
          c.address = Address.btc.create!({
            address: c.public_address,
            code: c.code,
          })
        end

      end
    end
  end
end
