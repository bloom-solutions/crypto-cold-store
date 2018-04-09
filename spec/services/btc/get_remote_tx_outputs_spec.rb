require 'rails_helper'

module Btc
  RSpec.describe GetRemoteTxOutputs do

    let(:vouts) do
      [
        {
          "value" => 0.01001774,
          "n" => 0,
          "scriptPubKey" =>  {
            "asm" => "asm...",
            "hex" => "76a914f",
            "reqSigs" => 1,
            "type" => "pubkeyhash",
            "addresses" => ["n423UweU1UvsebP1gmduMjaA2y2nz81iWR"]
          }
        },
        {
          "value" => 0.00050000,
          "n" => 1,
          "scriptPubKey" =>  {
            "asm" => "asm...",
            "hex" => "76a91477",
            "reqSigs" => 1,
            "type" => "pubkeyhash",
            "addresses" => ["mrNwna2PzEE1K9UqKQimkwRcf7qDRcQPMW"]
          }
        }
      ]
    end
    let(:remote_tx) do
      {
        "txid" => "c92f",
        "hash" => "c92f",
        "version" => 2,
        "size" => 373,
        "vsize" => 373,
        "locktime" => 1292029,
        "vin" => [ ],
        "vout" =>  vouts,
        "hex" => "020000000223"
      }
    end

    it "sets the vouts in the context" do
      resulting_ctx = described_class.execute(remote_tx: remote_tx)
      expect(resulting_ctx.remote_tx_outputs).to eq vouts
    end

  end
end
