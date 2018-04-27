module Btc
  module Addresses
    class Create

      extend LightService::Organizer

      def self.call(
        code:,
        master_public_key: ENV["BTC_MASTER_PUBLIC_KEY"],
        signatures_required: ENV["BTC_SIGNATURES_REQUIRED"]
      )
        ctx = {
          code: code,
          master_public_key: master_public_key,
          signatures_required: signatures_required,
        }

        with(ctx).reduce(actions)
      end

      def self.actions
        actions = [
          SplitMasterPublicKey,
          Creation::GetAddressIndex,
          Creation::GenAddress,
          Creation::SaveAddress,
        ]
      end

    end
  end
end
