module Addresses
  module Btc
    class Create

      extend LightService::Organizer

      def self.call(code)
        with(code: code).reduce(
          InitElectrumClient,
          Creation::FindUnusedAddress,
          Creation::SaveAddress,
          EnqueueImportAddressJob,
        )
      end

    end
  end
end
