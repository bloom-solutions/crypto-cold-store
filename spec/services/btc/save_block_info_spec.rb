require 'rails_helper'

module Btc
  RSpec.describe SaveBlockInfo do

    let(:remote_block) do
      { "hash" => "abc", "confirmations" => 3, "height" => 1292030 }
    end

    context "block exists" do
      let!(:block_btc) do
        create(:block, {
          coin: "btc",
          block_hash: "abc",
          confirmations: 2,
          height: 1292030,
        })
      end

      it "updates the block info" do
        block = described_class.execute(
          remote_block: remote_block,
          blocks: Block.btc,
        ).block
        expect(block).to eq block_btc
        expect(block.confirmations).to eq 3
      end
    end

    context "block does not exist" do
      it "saves the block info" do
        block = described_class.execute(
          remote_block: remote_block,
          blocks: Block.btc,
        ).block
        expect(block).to be_btc
        expect(block.block_hash).to eq "abc"
        expect(block.confirmations).to eq 3
        expect(block.height).to eq 1292030
      end
    end

  end
end
