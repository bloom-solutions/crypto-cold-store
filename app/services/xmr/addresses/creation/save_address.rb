module Xmr
  module Addresses
    module Creation
      class SaveAddress

        extend LightService::Action
        expects :public_address, :code
        promises :address

        executed do |c|
          c.address = ::Address.xmr.where({
            code: c.code,
            address: c.public_address,
          }).first_or_create!
        end

      end
    end
  end
end
