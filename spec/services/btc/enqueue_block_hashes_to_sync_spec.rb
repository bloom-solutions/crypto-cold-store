require 'rails_helper'

module Btc
  RSpec.describe EnqueueBlockHashesToSync do

    let(:block_hashes_count) { SetBlocks::MAX_CONFS + 1 }
    let(:block_hashes) { block_hashes_count.times.map { |n| "h#{n}" } }

    it "enqueues block hashes in blocks of #{described_class::SLICE}" do
      described_class.execute(block_hashes: block_hashes)
      expect(Btc::SyncBlocksJob)
        .to have_enqueued_sidekiq_job(%w(h0 h1 h2 h3 h4 h5 h6 h7 h8 h9))
      expect(Btc::SyncBlocksJob).to have_enqueued_sidekiq_job(%w(h10))
    end

  end
end
