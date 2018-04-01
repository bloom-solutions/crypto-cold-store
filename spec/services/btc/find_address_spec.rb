require 'rails_helper'

module Btc
  RSpec.describe FindAddress do

    let(:remote_tx) { { "address" => "abc" } }

    context "address is present" do
      let!(:address_1) { create(:address, coin: "ltc", address: "abc") }
      let!(:address_2) { create(:address, coin: "btc", address: "abc") }

      it "returns the btc address matching the given public address" do
        resulting_ctx = described_class.execute(remote_tx: remote_tx)
        expect(resulting_ctx.address).to eq address_2
      end
    end

    context "no address is found" do
      it "skips the rest of the steps" do
        resulting_ctx = described_class.execute(remote_tx: remote_tx)
        expect(resulting_ctx).to be_skip_remaining
      end
    end

  end
end
