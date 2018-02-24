require 'rails_helper'

module Addresses
  module Operations
    RSpec.describe FindOrCreate, vcr: {record: :once} do

      it "returns finds or create an address for the code-coin combination" do
        result = described_class.(params: {coin: "btc", code: "abc"})
        abc_address = result["model"]
        expect(abc_address).to be_present

        result = described_class.(params: {coin: "btc", code: "abc"})
        expect(result).to be_success
        expect(result["model"]).to eq abc_address
      end

    end
  end
end
