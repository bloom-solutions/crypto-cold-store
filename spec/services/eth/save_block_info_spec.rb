require 'rails_helper'

module Eth
  RSpec.describe SaveBlockInfo do

    let(:current_block_number) { 1292040 }
    let(:remote_block) do
      { "hash" => "abc", "number" => "0x#{1292030.to_s(16)}" }
    end

    context "block exists" do
      let!(:block_eth) do
        create(:block, {
          coin: "eth",
          block_hash: "abc",
          confirmations: 2,
          height: 1292030,
        })
      end

      it "updates the block info" do
        block = described_class.execute(
          remote_block: remote_block,
          current_block_number: current_block_number,
          blocks: Block.eth,
        ).block
        expect(block).to eq block_eth
        expect(block.confirmations).to eq 11
        expect(block.block_hash).to eq "abc"
      end
    end

    context "block does not exist" do
      it "saves the block info" do
        block = described_class.execute(
          remote_block: remote_block,
          current_block_number: current_block_number,
          blocks: Block.eth,
        ).block
        expect(block).to be_eth
        expect(block.block_hash).to eq "abc"
        expect(block.confirmations).to eq 11
        expect(block.height).to eq 1292030
      end
    end

  end
end
