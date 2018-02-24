require 'rails_helper'

module Addresses
  module Btc
    RSpec.describe Create do

      it "calls actions in order" do
        actions = [
          InitElectrumClient,
          Creation::FindUnusedAddress,
          Creation::SaveAddress,
        ]

        ctx = LightService::Context.new(code: "123")

        actions.each do |action|
          expect(action).to receive(:execute).with(ctx).and_return(ctx)
        end

        described_class.("123")
      end

    end
  end
end
