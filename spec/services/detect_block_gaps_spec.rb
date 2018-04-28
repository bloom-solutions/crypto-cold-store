require 'rails_helper'

RSpec.describe DetectBlockGaps do

  let!(:block_8) { create(:block, coin: "btc", height: 10) }
  let!(:block_5) { create(:block, coin: "btc", height: 7) }
  let!(:block_1) { create(:block, coin: "btc", height: 3) }
  let!(:block_2) { create(:block, coin: "btc", height: 4) }
  let!(:block_4) { create(:block, coin: "btc", height: 6) }

  it "detects gaps in blocks" do
    resulting_ctx = described_class.execute(blocks: Block.btc)
    expect(resulting_ctx.unsynced_blocks).to match_array([5, 8, 9])
  end

end
