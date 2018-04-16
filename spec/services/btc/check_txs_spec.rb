require 'rails_helper'

module Btc
  RSpec.describe CheckTxs, vcr: {record: :once} do

    it "syncs blocks" do
      described_class.()
      # Block number below is the one recorded. When re-recording, change this
      expect(SyncBlockJob).to have_enqueued_sidekiq_job(1293074)
    end

  end
end
