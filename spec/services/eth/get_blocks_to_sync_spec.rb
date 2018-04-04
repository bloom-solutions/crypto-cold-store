require 'rails_helper'

module Eth
  RSpec.describe GetBlocksToSync do

    context "there are known ethereum txs" do
      let(:address_other) { create(:address, coin: "btc") }
      let(:address) { create(:address, coin: "eth") }
      before do
        create(:tx, address: address, block_index: 2, confirmations: 1)
        create(:tx, address: address, block_index: 2, confirmations: 3)
        create(:tx, address: address, block_index: 33, confirmations: 18)
        create(:tx, address: address, block_index: 32, confirmations: 18)
        create(:tx, address: address_other, block_index: 34, confirmations: 10)
      end

      it "sets unsynced_blocks to include blocks that have not reached #{described_class::MAX_CONFS}" do
        resulting_ctx = described_class.execute(current_block_number: 35)
        blocks_below_conf = 35 - described_class::MAX_CONFS
        expected_unsynced_blocks = [2] + (blocks_below_conf..35).to_a
        expect(resulting_ctx.unsynced_blocks).
          to match_array(expected_unsynced_blocks)
      end
    end

    context "there are no ethereum txs" do
      it "sets unsynced_blocks to include blocks that have not reached #{described_class::MAX_CONFS} to the current_block_number" do
        resulting_ctx = described_class.execute(current_block_number: 35)
        blocks_below_conf = 35 - described_class::MAX_CONFS
        expect(resulting_ctx.unsynced_blocks).
          to match_array(blocks_below_conf..35)
      end
    end

  end
end
