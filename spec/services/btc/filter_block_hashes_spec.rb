require 'rails_helper'

module Btc
  RSpec.describe FilterBlockHashes do

    it "removes the block_hashes whose blocks have been sufficiently confirmed" do
      create(:block, coin: "btc", block_hash: "h1", confirmations: 3)
      create(:block, {
        coin: "btc",
        block_hash: "h2",
        confirmations: GetBlocksToSync::MAX_CONFS,
      })
      create(:block, {
        coin: "btc",
        block_hash: "h3",
        confirmations: GetBlocksToSync::MAX_CONFS+1,
      })
      create(:block, coin: "btc", block_hash: "h4", confirmations: 1)

      result = described_class.execute(
        blocks: Block.btc,
        block_hashes: %w(h1 h2 h3 h4),
      )

      expect(result.block_hashes).to match_array(%w(h1 h4))
    end

    it "does not remove the block_hashes whose blocks don't exist" do
      result = described_class.execute(blocks: Block.btc, block_hashes: %w(h1))
      expect(result.block_hashes).to eq %w(h1)
    end

  end
end
