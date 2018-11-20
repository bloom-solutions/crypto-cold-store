require 'rails_helper'

module Btc
  RSpec.describe GetRemoteTxOutputAddresses do

    let(:remote_tx) do
      {
        "txid" => "c92f",
        "hash" => "c92f",
        "version" => 2,
        "size" => 373,
        "vsize" => 373,
        "locktime" => 1292029,
        "vin" => [],
        "vout" =>  [remote_tx_output],
        "hex" => "020000000223"
      }
    end

    context "output is not a `pubkeyhash`" do
      let(:remote_tx_output) do
        {
          "value" => 0.01001774,
          "n" => 0,
          "scriptPubKey" => {
            "asm" => "asm...",
            "hex" => "76a914f",
            "reqSigs" => 1,
            "type" => "multisig",
            "addresses" => ["n423UweU1UvsebP1gmduMjaA2y2nz81iWR", "..."]
          }
        }
      end

      it "skips the rest of the steps" do
        resulting_ctx = described_class.execute(
          remote_tx: remote_tx,
          remote_tx_output: remote_tx_output,
        )
        expect(resulting_ctx).to be_skip_remaining
      end
    end

    context "address is a `pubkeyhash`" do
      let(:remote_tx_output) do
        {
          "value" => 0.01001774,
          "n" => 0,
          "scriptPubKey" => {
            "asm" => "asm...",
            "hex" => "76a914f",
            "reqSigs" => 1,
            "type" => "pubkeyhash",
            "addresses" => ["n423UweU1UvsebP1gmduMjaA2y2nz81iWR"]
          }
        }
      end

      it "sets remote_tx_output_addresses" do
        resulting_ctx = described_class.execute(
          remote_tx: remote_tx,
          remote_tx_output: remote_tx_output,
        )
        expect(resulting_ctx.remote_tx_output_addresses)
          .to match_array(["n423UweU1UvsebP1gmduMjaA2y2nz81iWR"])
      end
    end

    context "address is a `scripthash`" do
      let(:remote_tx_output) do
        {
          "value" => 0.01001774,
          "n" => 0,
          "scriptPubKey" => {
            "asm" => "asm...",
            "hex" => "76a914f",
            "reqSigs" => 1,
            "type" => "scripthash",
            "addresses" => ["3AHSUvWK"]
          }
        }
      end

      it "returns the btc address matching the given public address" do
        resulting_ctx = described_class.execute(
          remote_tx: remote_tx,
          remote_tx_output: remote_tx_output,
        )
        expect(resulting_ctx.remote_tx_output_addresses)
          .to match_array(["3AHSUvWK"])
      end
    end

  end
end
