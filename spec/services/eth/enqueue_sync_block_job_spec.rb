require 'rails_helper'

module Eth
  RSpec.describe EnqueueSyncBlockJob do

    it "enqueues #{Eth::SyncBlockJob} for each unsynced_block" do
      described_class.execute(unsynced_block: 2)
      expect(SyncBlockJob).to have_enqueued_sidekiq_job(2)
    end

  end
end
