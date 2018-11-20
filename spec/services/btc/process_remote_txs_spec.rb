require 'rails_helper'

module Btc
  RSpec.describe ProcessRemoteTxs do

    let(:remote_txs) do
      [
        {
          "txid" => "c92f",
          "hash" => "c92f",
          "version" => 2,
          "size" => 373,
          "vsize" => 373,
          "locktime" => 1292029,
          "vin" => [],
          "vout" =>  [
            {
              "value" => 0.01001774,
              "n" => 0,
              "scriptPubKey" => {
                "asm" => "asm...",
                "hex" => "76a914f",
                "reqSigs" => 1,
                "type" => "pubkeyhash",
                "addresses" => ["addr1"]
              }
            }
          ],
          "hex" => "020000000223"
        }
      ]
    end

    context "there are addresses that match some of the output_addresses" do
      let!(:address) { create(:address, coin: "btc", address: "addr1") }

      it "saves/updates those tx data" do
        described_class.(remote_txs: remote_txs)
        expect(Tx.of_coin("btc").exists?(amount: 0.01001774)).to be true
      end
    end

    context "there are no addresses that match the output_addresses" do
      it "does nothing" do
        described_class.(remote_txs: remote_txs)
        expect(Tx.of_coin("btc")).to be_empty
      end
    end

  end
end
