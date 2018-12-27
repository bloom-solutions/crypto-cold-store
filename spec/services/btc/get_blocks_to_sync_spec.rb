require 'rails_helper'

module Btc
  RSpec.describe GetBlocksToSync do

    context "there are no block records" do
      let(:current_block_number) { 23 }
      let(:resulting_ctx) do
        described_class.execute(
          current_block_number: current_block_number,
          blocks: Block.btc,
        )
      end
      subject { resulting_ctx.unsynced_blocks }
      it { is_expected.to match_array [23] }
    end

    context "there are block records; there are unknown blocks" do
      let(:current_block_number) { 23 }
      let(:resulting_ctx) do
        described_class.execute(
          current_block_number: current_block_number,
          blocks: Block.btc,
        )
      end
      subject { resulting_ctx.unsynced_blocks }

      before do
        create(:block, {
          coin: "btc",
          height: 20,
          confirmations: described_class::MAX_CONFS,
        })
      end

      it "is an array of unknown blocks up to the current_block_number" do
        is_expected.to match_array(20..23)
      end
    end

    context "there are block records; there are blocks with unsufficient confirmations" do
      let(:current_block_number) { 23 }
      let(:resulting_ctx) do
        described_class.execute(
          current_block_number: current_block_number,
          blocks: Block.btc,
        )
      end
      subject { resulting_ctx.unsynced_blocks }

      before do
        create(:block, {
          coin: "eth",
          height: 22,
          confirmations: described_class::MAX_CONFS,
        })
        create(:block, {
          coin: "btc",
          height: 20,
          confirmations: described_class::MAX_CONFS - 1,
        })
        create(:block, {
          coin: "btc",
          height: 21,
          confirmations: described_class::MAX_CONFS - 2,
        })
        create(:block, {
          coin: "btc",
          height: 22,
          confirmations: described_class::MAX_CONFS,
        })
      end

      it "is an array from earliest block with insufficient confs up to the current_block_number" do
        is_expected.to match_array((20..23).to_a)
      end
    end

  end
end
