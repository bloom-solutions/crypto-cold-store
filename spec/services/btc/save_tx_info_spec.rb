require 'rails_helper'

module Btc
  RSpec.describe SaveTxInfo do

    let(:block) do
      create(:block, {
        block_hash: "1bc",
        confirmations: 1,
      })
    end

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

    let!(:address) do
      create(:address, {
        coin: "btc",
        address: "n423UweU1UvsebP1gmduMjaA2y2nz81iWR",
      })
    end

    context "tx does not exist locally" do
      it "saves the tx" do
        tx_count = Tx.count
        tx = described_class.execute({
          block: block,
          address: address,
          remote_tx: remote_tx,
          remote_tx_output: remote_tx_output,
        }).tx
        expect(Tx.count).to eq tx_count+1
        expect(tx.tx_id).to eq "c92f"
        expect(tx.confirmations).to eq 1
        expect(tx.amount).to eq 0.01001774
      end
    end

    context "tx exists locally" do
      it "updates the tx" do
        described_class.execute(
          block: block,
          address: address,
          remote_tx: remote_tx,
          remote_tx_output: remote_tx_output,
        )

        block.update_attributes!(confirmations: 2)

        described_class.execute(
          block: block,
          address: address,
          remote_tx: remote_tx,
          remote_tx_output: remote_tx_output,
        )
        tx = Tx.find_by(tx_id: remote_tx["txid"])
        expect(tx.confirmations).to eq 2
      end
    end

    context "block does not exist" do
      it "sets the confirmations to 0" do
        tx = described_class.execute(
          address: address,
          remote_tx: remote_tx,
          remote_tx_output: remote_tx_output,
        ).tx

        expect(tx.confirmations).to be_zero
      end
    end

  end
end
