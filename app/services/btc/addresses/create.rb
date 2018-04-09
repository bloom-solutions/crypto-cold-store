module Btc
  module Addresses
    class Create

      extend LightService::Organizer

      def self.call(
        code:,
        master_public_key: ENV["BTC_MASTER_PUBLIC_KEY"],
        electrum_host: ENV["ELECTRUM_HOST"]
      )
        ctx = {
          code: code,
          master_public_key: master_public_key,
          electrum_host: electrum_host,
        }

        actions = actions_for({
          master_public_key: master_public_key,
          electrum_host: electrum_host,
        })

        with(ctx).reduce(actions)
      end

      def self.actions_for(master_public_key:, electrum_host:)
        actions = if master_public_key.present?
                    [
                      InitBtcrubyKeychain,
                      Creation::Btcruby::GetAddressIndex,
                      Creation::Btcruby::GenAddress,
                    ]
                  else
                    [
                      InitElectrumClient,
                      Creation::Electrum::FindUnusedAddress,
                    ]
                  end

        actions += [
          Creation::SaveAddress,
        ]
      end

    end
  end
end
