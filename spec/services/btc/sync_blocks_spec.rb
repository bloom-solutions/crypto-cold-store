require 'rails_helper'

module Btc
  RSpec.describe SyncBlocks do

    let(:blocks) do
      {
        1444020 => "00000000000000c1c2703a5e2e5d56ea3ae0a682f5905d6e545e0a661653ef94",
        1444021 => "00000000000e82189abc3cd7e878f8dc104f8ce9c54bc1c83863505e117b1a7f",
      }
    end

    it "syncs the blocks with the hashes", vcr: {record: :once} do
      described_class.(blocks.values)

      blocks.each do |height, hash|
        expect(Block.btc.exists?(height: height)).to be true
      end
    end

  end
end
