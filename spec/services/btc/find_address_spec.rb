require 'rails_helper'

module Btc
  RSpec.describe FindAddress do

    context "remote_tx_output_addresses' first element exists in the db" do
      let(:remote_tx_output_addresses) do
        ["n423UweU1UvsebP1gmduMjaA2y2nz81iWR"]
      end
      let!(:address_1) do
        create(:address, {
          coin: "ltc",
          address: "n423UweU1UvsebP1gmduMjaA2y2nz81iWR",
        })
      end
      let!(:address_2) do
        create(:address, {
          coin: "btc",
          address: "n423UweU1UvsebP1gmduMjaA2y2nz81iWR",
        })
      end

      it "returns the btc address matching the given public address" do
        resulting_ctx = described_class.execute(
          remote_tx_output_addresses: remote_tx_output_addresses,
        )
        expect(resulting_ctx.address).to eq address_2
      end
    end

    context "no address is found" do
      let(:remote_tx_output_addresses) do
        ["n423UweU1UvsebP1gmduMjaA2y2nz81iWR"]
      end

      it "skips the rest of the steps" do
        resulting_ctx = described_class.execute(
          remote_tx_output_addresses: remote_tx_output_addresses,
        )
        expect(resulting_ctx).to be_skip_remaining
      end
    end

  end
end
