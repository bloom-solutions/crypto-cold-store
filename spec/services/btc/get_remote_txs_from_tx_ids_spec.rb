require 'rails_helper'

module Btc
  RSpec.describe GetRemoteTxsFromTxIds do

    let(:bitcoiner_client) { InitBitcoinerClient.execute.bitcoiner_client }
    let(:tx_ids) do
      [
        "53c38b761f228332fa54a48697441be969eb727d48ab5c1b9f5dcec89bea2216",
        "d0d9f56a9eff55c0b40a3fe696d080d9d900de9203bf2c3fc014e15756ce1a97",
        "abc",
      ]
    end

    it "fetches the tx details from the array of tx_ids, removing any nils", vcr: {record: :once} do
      resulting_ctx = described_class.execute({
        bitcoiner_client: bitcoiner_client,
        tx_ids: tx_ids,
      })

      remote_txs = resulting_ctx.remote_txs
      expect(remote_txs.size).to eq 2

      expect(remote_txs[0]["txid"]).to eq tx_ids[0]
      expect(remote_txs[0]["vout"][0]["value"]).to eq 0.325

      expect(remote_txs[1]["txid"]).to eq tx_ids[1]
      expect(remote_txs[1]["vout"][0]["value"]).to eq 0.001
    end

  end
end
