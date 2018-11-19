require 'rails_helper'

module Btc
  RSpec.describe EnqueueBlockHashesToSync do

    let(:block_hashes) do
      6.times.map do |n|
        "h#{n}"
      end
    end

    it "enqueues block hashes in blocks of #{described_class::SLICE}" do
      described_class.execute(block_hashes: block_hashes)
      expect(Btc::SyncBlocksJob).to have_enqueued_sidekiq_job(%w(h0 h1 h2 h3 h4))
      expect(Btc::SyncBlocksJob).to have_enqueued_sidekiq_job(%w(h5))
    end

  end
end
