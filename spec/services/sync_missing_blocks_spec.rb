require 'rails_helper'

RSpec.describe SyncMissingBlocks do

  describe "given `btc` param" do
    let!(:block_1) { create(:block, coin: "btc", height: 1443361) }
    let!(:block_3) { create(:block, coin: "btc", height: 1443363) }

    it "enqueues missing blocks", vcr: {record: :once} do
      described_class.("btc")
      expect(Block.btc.exists?(height: 1443362)).to be true
    end
  end

  describe "given `eth` param" do
    let!(:block_1) { create(:block, coin: "eth", height: 1) }
    let!(:block_3) { create(:block, coin: "eth", height: 3) }

    it "enqueues missing blocks" do
      described_class.("eth")
      expect(Eth::SyncBlockJob).to have_enqueued_sidekiq_job(2)
    end
  end

end
