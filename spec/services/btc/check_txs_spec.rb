require 'rails_helper'

module Btc
  RSpec.describe CheckTxs, vcr: {record: :once} do

    it "syncs blocks" do
      described_class.()

      # Block hash below is the one recorded. When re-recording, change this
      expect(SyncBlocksJob)
        .to have_enqueued_sidekiq_job(%w(00000000000e82189abc3cd7e878f8dc104f8ce9c54bc1c83863505e117b1a7f))
    end

  end
end
