require 'rails_helper'

module Btc
  RSpec.describe GetBlocksHashes do

    let(:client) { InitBitcoinerClient.execute.bitcoiner_client }

    it "gets the unsynced_blocks' hashes", vcr: {record: :once} do
      resulting_ctx = described_class.execute(
        unsynced_blocks: [1443356, 1443357],
        bitcoiner_client: client,
      )

      block_hashes = resulting_ctx.block_hashes
      expect(block_hashes).to match_array([
        "000000000000006f7cef9ff5d73c81eec620a75a05856c4d1f2ad40e009fdfad",
        "000000000000009c184b9d16641b5fa81b9c917c29db56a2ccd9396be82992bb",
      ])
    end

  end
end
