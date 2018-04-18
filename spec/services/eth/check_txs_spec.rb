require 'rails_helper'

module Eth
  RSpec.describe CheckTxs, vcr: {record: :once} do

    it "enqueues blocks to sync" do
      described_class.()
      # NOTE: Number below is hard-coded in the cassette.
      # Change when re-recording
      expect(SyncBlockJob).to have_enqueued_sidekiq_job(3059463)
    end

  end
end
