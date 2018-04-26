require 'rails_helper'

module Btc
  module Addresses
    RSpec.describe Create do

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
        })

        actions.each do |action|
          expect(action).to receive(:execute).with(ctx).and_return(ctx)
        end

        described_class.(code: "123", master_public_key: "mympk")
      end

    end
  end
end
