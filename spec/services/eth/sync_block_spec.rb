require 'rails_helper'

module Eth
  RSpec.describe SyncBlock, vcr: {record: :once} do

    let!(:address) do
      create(:address, {
        coin: "eth",
        address: "0x387288aa3effea7d47cdf0b5dbd29534c2541841",
      })
    end

    before do
      create(:block, coin: "eth", height: 2952850, block_hash: "something-else")
    end

    it "syncs the block txs of known addresses" do
      described_class.(2952850)
      tx = ::Tx.of_coin(:eth).
        find_by(tx_id: "0x635e994ceeecf74731a5aeb1b43d29f024ab2a6c1b234328b5a1bc996b6a01e6")

      block_in_fork = Block.eth.find_by(block_hash: "something-else")
      expect(block_in_fork).to be_nil
      expect(tx).to be_present
      expect(tx.block).to be_present
      expect(tx.amount.round(18).to_f).to eq 0.229788202932067616
      expect(tx.address).to eq address
      expect(tx.confirmations).to be > 20 # more than what it is at time of writing
    end

  end
end
