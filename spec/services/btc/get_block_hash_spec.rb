require 'rails_helper'

module Btc
  RSpec.describe GetBlockHash, vcr: {record: :once} do

    context ".execute" do
      let(:bitcoiner_client) { InitBitcoinerClient.execute.bitcoiner_client }
      it "sets the block_hash of the block_index in the context" do
        resulting_ctx = described_class.execute(
          bitcoiner_client: bitcoiner_client,
          block_index: 2000,
        )
        expect(resulting_ctx.block_hash).
          to eq "0000000005bdbddb59a3cd33b69db94fa67669c41d9d32751512b5d7b68c71cf"
      end
    end

    context ".of_height" do
      it "returns the block_hash of the given height" do
        hash = described_class.of_height(1292018)
        expect(hash).
          to eq "00000000ff6025486c994a7a7ea1e815e43cea56ebd8b7f801f84c5cb8cecb88"
      end
    end

  end
end
