require 'rails_helper'

module Eth
  RSpec.describe CheckConfirmations do

    context "block is sufficiently confirmed" do
      let!(:block) do
        create(:block, {
          coin: "eth",
          height: 212,
          confirmations: GetBlocksToSync::MAX_CONFS,
        })
      end

      it "skips the rest of the actions" do
        result = described_class.execute(blocks: Block.eth, block_height: 212)
        expect(result).to be_success
        expect(result).to be_skip_remaining
      end
    end

    context "block is not sufficiently confirmed" do
      let!(:block) do
        create(:block, {
          coin: "eth",
          height: 212,
          confirmations: GetBlocksToSync::MAX_CONFS-1,
        })
      end

      it "does nothing" do
        result = described_class.execute(blocks: Block.eth, block_height: 212)
        expect(result).to be_success
        expect(result).to_not be_skip_remaining
      end
    end

    context "block does not exist" do
      it "does nothing" do
        result = described_class.execute(blocks: Block.eth, block_height: 212)
        expect(result).to be_success
        expect(result).to_not be_skip_remaining
      end
    end

  end
end
