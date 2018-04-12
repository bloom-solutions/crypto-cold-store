require 'rails_helper'

module Btc
  RSpec.describe SyncBlock, vcr: {record: :once} do

    let!(:address) do
      create(:address, {
        coin: "btc",
        address: "n4VWRzZtnfRSqhty4wfZbd5N2nPSUsLgYo",
      })
    end

    it "syncs the block txs of known addresses" do
      described_class.(1291920)
      tx = ::Tx.of_coin(:btc).
        find_by(tx_id: "91db12fc69c98a2fed7e419859280c64c71c8f34f874a9022a114e9d509253ca")

      expect(tx).to be_present
      expect(tx.block).to be_present
      expect(tx.amount.to_f).to eq 1.799772
      expect(tx.address).to eq address
      expect(tx.confirmations).to be > 20 # more than what it is at time of writing
    end

  end
end
