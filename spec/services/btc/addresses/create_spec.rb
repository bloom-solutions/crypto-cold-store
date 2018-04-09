require 'rails_helper'

module Btc
  module Addresses
    RSpec.describe Create do

      context "there is a BTC_MASTER_PUBLIC_KEY env variable" do
        it "calls actions in order" do
          actions = [
            InitBtcrubyKeychain,
            Creation::Btcruby::GetAddressIndex,
            Creation::Btcruby::GenAddress,
            Creation::SaveAddress,
          ]

          ctx = LightService::Context.new({
            code: "123",
            master_public_key: "mympk",
            electrum_host: ENV["ELECTRUM_HOST"],
          })

          actions.each do |action|
            expect(action).to receive(:execute).with(ctx).and_return(ctx)
          end

          described_class.(code: "123", master_public_key: "mympk")
        end
      end

      context "there is no BTC_MASTER_PUBLIC_KEY env variable" do
        it "calls actions in order" do
          actions = [
            InitElectrumClient,
            Creation::Electrum::FindUnusedAddress,
            Creation::SaveAddress,
          ]

          ctx = LightService::Context.new(
            code: "123",
            master_public_key: "",
            electrum_host: "https://somehost.com",
          )

          actions.each do |action|
            expect(action).to receive(:execute).with(ctx).and_return(ctx)
          end

          described_class.(
            code: "123",
            master_public_key: "",
            electrum_host: "https://somehost.com",
          )
        end
      end

    end
  end
end
