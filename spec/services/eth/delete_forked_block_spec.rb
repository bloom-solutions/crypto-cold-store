require 'rails_helper'

module Eth
  RSpec.describe DeleteForkedBlock do

    let(:remote_block) do
      { "number" => "0x#{210.to_s(16)}", "hash" => "abd" }
    end

    context "local block with block_height exists whose hash does not match the remote_block" do
      let!(:block_btc) do
        create(:block, height: 210, coin: "btc", block_hash: "abc")
      end
      let!(:block_eth) do
        create(:block, height: 210, coin: "eth", block_hash: "abc")
      end

      it "deletes the local block" do
        described_class.execute(remote_block: remote_block)
        expect(Block.eth.find_by(block_hash: "abc")).to be_nil
        expect(Block.btc.find_by(block_hash: "abc")).to be_present
      end
    end

    context "local block with block_hash exists and it matches the remote_block" do
      let!(:block_btc) do
        create(:block, height: 210, coin: "btc", block_hash: "abd")
      end
      let!(:block_eth) do
        create(:block, height: 210, coin: "eth", block_hash: "abd")
      end

      it "does nothing" do
        described_class.execute(remote_block: remote_block)
        expect(Block.eth.find_by(block_hash: "abd")).to be_present
        expect(Block.btc.find_by(block_hash: "abd")).to be_present
      end
    end

  end
end
