module Eth
  module Addresses
    RSpec.describe Create do

      it "calls actions in order" do
        actions = [
          InitBip44Wallet,
          Creation::Bip44Wallet::GetAddressIndex,
          Creation::Bip44Wallet::GenAddress,
          Creation::SaveAddress,
        ]

        ctx = LightService::Context.new(
          code: "123",
          master_public_key: ENV["ETH_MASTER_PUBLIC_KEY"],
        )

        actions.each do |action|
          expect(action).to receive(:execute).with(ctx).and_return(ctx)
        end

        # master_public_key defaults to ENV["ETH_MASTER_PUBLIC_KEY"]
        described_class.(code: "123")
      end

    end
  end
end
