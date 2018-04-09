require 'rails_helper'

module Btc
  RSpec.describe GetRemoteBlock, vcr: {record: :once} do

    let(:bitcoiner_client) { InitBitcoinerClient.execute.bitcoiner_client }
    let(:block_hash) do
      "00000000b4fc196c3e2a6674cdc5bc03b6690e5d81fc63595c4d163a14858527"
    end

    it "returns the block with all the txs" do
      resulting_ctx = described_class.execute(
        bitcoiner_client: bitcoiner_client,
        block_hash: block_hash,
      )
      remote_block = resulting_ctx.remote_block
      expect(remote_block["tx"]).to_not be_empty
      expect(remote_block["tx"].first["txid"]).
        to eq "25e993e272df82acd526f96a92e8f090e27f000837b3d7119c1b933a9a5a27c9"
    end

  end
end
