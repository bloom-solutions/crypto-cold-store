require 'rails_helper'

module Btc
  RSpec.describe CheckTxs, vcr: {record: :once} do

    let!(:address) do
      create(:address, {
        coin: "btc",
        address: "muhtvdmsnbQEPFuEmxcChX58fGvXaaUoVt",
      })
    end
    let(:expected_txids) do
      txids = []
      tx_response = JSON.parse(File.read(FIXTURES_DIR.join("btc-listtransactions.json")))
      tx_response["result"].reverse.each do |tx|
        txids << tx["txid"]
        break if tx["txid"] == known_tx.tx_id
      end
      txids.to_set
    end
    let!(:known_tx) do
      create(:tx, {
        address: address,
        tx_id: "abbfdbb3b7f52dd11c4f56066e6e0270fc2b120562bbff01a5db81328f6798f5",
        amount: 1.0,
        confirmations: 0,
      })
    end

    it "fetches unknown txs or below #{GetRemoteTxs::MAX_CONFS} confs" do
      described_class.()

      expect(Tx.pluck(:tx_id).to_set).to be_subset(expected_txids)
    end

  end
end
