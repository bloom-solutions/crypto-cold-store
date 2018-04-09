require 'rails_helper'

module Btc
  RSpec.describe GetCurrentBlock, vcr: {record: :once} do

    let(:client) { InitBitcoinerClient.execute.bitcoiner_client}

    it "gets the latest bitcoin block height" do
      resulting_ctx = described_class.execute(bitcoiner_client: client)
      expect(resulting_ctx.current_block_number).
        to be >= 1292018 # block as of writing
      expect(resulting_ctx.current_block_hash).
        to eq "0000000024b263838f8799737c098f7c1f20d2cd05b65f97227411483c2b9cae"
    end

  end
end
