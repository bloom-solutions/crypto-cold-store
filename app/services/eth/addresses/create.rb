module Eth
  module Addresses
    class Create

      extend LightService::Organizer

      def self.call(code:, master_public_key: ENV["ETH_MASTER_PUBLIC_KEY"])
        with(code: code, master_public_key: master_public_key).reduce(
          InitBip44Wallet,
          Creation::Bip44Wallet::GetAddressIndex,
          Creation::Bip44Wallet::GenAddress,
          Creation::SaveAddress,
        )
      end

    end
  end
end
