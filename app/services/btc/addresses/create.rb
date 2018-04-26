module Btc
  module Addresses
    class Create

      extend LightService::Organizer

      def self.call(
        code:,
        master_public_key: ENV["BTC_MASTER_PUBLIC_KEY"]
      )
        ctx = {
          code: code,
          master_public_key: master_public_key,
        }

        actions = actions_for({
          master_public_key: master_public_key,
        })

        with(ctx).reduce(actions)
      end

      def self.actions_for(master_public_key:)
        actions = [
          InitBtcrubyKeychain,
          Creation::Btcruby::GetAddressIndex,
          Creation::Btcruby::GenAddress,
          Creation::SaveAddress,
        ]
      end

    end
  end
end
