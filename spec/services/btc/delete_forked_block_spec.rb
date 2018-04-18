require 'rails_helper'

module Btc
  RSpec.describe DeleteForkedBlock do

    let(:remote_block) { { "height" => 210, "hash" => "abd" } }

    context "local block with block_height exists whose hash does not match the remote_block" do
      let!(:block_btc) do
        create(:block, height: 210, coin: "btc", block_hash: "abc")
      end

      it "deletes the local block" do
        described_class.execute(remote_block: remote_block, blocks: Block.btc)
        expect(Block.btc.find_by(block_hash: "abc")).to be_nil
      end
    end

    context "local block with block_hash exists and it matches the remote_block" do
      let!(:block_btc) do
        create(:block, height: 210, coin: "btc", block_hash: "abd")
      end

      it "does nothing" do
        described_class.execute(remote_block: remote_block, blocks: Block.btc)
        expect(Block.btc.find_by(block_hash: "abd")).to be_present
      end
    end

  end
end
