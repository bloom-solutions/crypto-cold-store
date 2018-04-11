require 'rails_helper'

module Btc
  RSpec.describe GetRemoteTx, vcr: {record: :once} do

    let(:bitcoiner_client) { InitBitcoinerClient.execute.bitcoiner_client }
    let(:tx_id) do
      "53c38b761f228332fa54a48697441be969eb727d48ab5c1b9f5dcec89bea2216"
    end

    it "sets remote_tx from results of getrawtransaction of the tx_id" do
      resulting_ctx = described_class.execute({
        bitcoiner_client: bitcoiner_client,
        tx_id: tx_id,
      })

      remote_tx = resulting_ctx.remote_tx

      expect(remote_tx["txid"]).to eq tx_id
      expect(remote_tx["vout"][0]["value"]).to eq 0.325
    end

  end
end
