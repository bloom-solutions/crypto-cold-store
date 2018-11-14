require 'rails_helper'

module Btc
  RSpec.describe GetRemoteTxs do

    let(:bitcoiner_client) { InitBitcoinerClient.execute.bitcoiner_client }
    let(:remote_blocks) do
      [
        { "tx" => [{"txid" => "1"}] },
        { "tx" => [{"txid" => "2"}] }
      ]
    end

    it "sets remote_txs from remote_blocks" do
      resulting_ctx = described_class.execute({
        bitcoiner_client: bitcoiner_client,
        remote_blocks: remote_blocks,
      })

      remote_txs = resulting_ctx.remote_txs

      expect(remote_txs[0]["txid"]).to eq "1"
      expect(remote_txs[1]["txid"]).to eq "2"
    end

  end
end
