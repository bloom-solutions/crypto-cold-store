require 'rails_helper'

module Eth
  RSpec.describe GetBlocksToSync do

    context "there are known ethereum txs" do
      let!(:block_eth_2) do
        create(:block, coin: "eth", height: 2)
      end
      let!(:block_eth_3) do
        create(:block, coin: "eth", height: 3)
      end
      let!(:block_eth_5) do
        create(:block, coin: "eth", height: 5)
      end

      it "sets unsynced_blocks to include earliest insufficiently confirmed block until the current block number" do
        resulting_ctx = described_class.execute(
          current_block_number: 7,
          blocks: Block.eth,
        )
        expected_unsynced_blocks = 2..7
        expect(resulting_ctx.unsynced_blocks).
          to match_array(expected_unsynced_blocks)
      end
    end

    context "there are no ethereum blocks" do
      it "sets unsynced_blocks to include just the current_block_number" do
        resulting_ctx = described_class.execute(
          current_block_number: 35,
          blocks: Block.eth,
        )
        expect(resulting_ctx.unsynced_blocks).to match_array([35])
      end
    end

  end
end
