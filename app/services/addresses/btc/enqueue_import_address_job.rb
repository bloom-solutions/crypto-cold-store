module Addresses
  module Btc
    class EnqueueImportAddressJob

      extend LightService::Action
      expects :public_address

      executed do |c|
        ::Btc::ImportAddressJob.perform_async(c.public_address)
      end

    end
  end
end
