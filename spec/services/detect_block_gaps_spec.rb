require 'rails_helper'

RSpec.describe DetectBlockGaps do

  let!(:block_8) { create(:block, coin: "btc", height: 8) }
  let!(:block_5) { create(:block, coin: "btc", height: 5) }
  let!(:block_1) { create(:block, coin: "btc", height: 1) }
  let!(:block_2) { create(:block, coin: "btc", height: 2) }
  let!(:block_4) { create(:block, coin: "btc", height: 4) }

  it "detects gaps in blocks" do
    resulting_ctx = described_class.execute(blocks: Block.btc)
    expect(resulting_ctx.unsynced_blocks).to match_array([3, 6, 7])
  end

end
