require 'rails_helper'

module Btc
  RSpec.describe CheckTxs, vcr: {record: :once} do

    it "syncs blocks" do
      described_class.()

      # Block number below is the one recorded. When re-recording, change this
      expect(Block.btc.exists?(height: 1443363))
    end

  end
end
