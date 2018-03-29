require 'rails_helper'

module Btc
  RSpec.describe ImportAddress do

    it "calls actions in order" do
      actions = [
        InitBitcoinerClient,
        SendImportRequest,
      ]

      ctx = LightService::Context.new(public_address: "123")

      actions.each do |action|
        expect(action).to receive(:execute).with(ctx).and_return(ctx)
      end

      described_class.("123")
    end

  end
end
