require 'rails_helper'

RSpec.describe SyncMissingBlocks do

  # NOTE: btc and eth for now
  %w(btc eth).each do |coin|
    describe "given `#{coin}` param" do
      let!(:block_1) { create(:block, coin: coin, height: 1) }
      let!(:block_3) { create(:block, coin: coin, height: 3) }

      it "enqueues missing blocks" do
        described_class.(coin)
        coin_namespace = coin.classify.constantize
        job_class = coin_namespace.const_get("SyncBlockJob")
        expect(job_class).to have_enqueued_sidekiq_job(2)
      end
    end
  end

end
