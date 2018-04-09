require 'rails_helper'

module Btc
  RSpec.describe SaveTxInfo do

    let(:remote_block) do
      {
        "hash" => "1bc",
        "confirmations" => 1,
      }
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
          remote_block: remote_block,
          address: address,
          remote_tx: remote_tx,
          remote_tx_output: remote_tx_output,
          block_index: 2000,
        }).tx
        expect(Tx.count).to eq tx_count+1
        expect(tx.tx_id).to eq "c92f"
        expect(tx.confirmations).to eq 1
        expect(tx.amount).to eq 0.01001774
        expect(tx.block_index).to eq 2000
      end
    end

    context "tx exists locally" do
      let(:remote_block_update) do
        {
          "hash" => "1bc",
          "confirmations" => 2,
        }
      end

      it "updates the tx" do
        described_class.execute(
          remote_block: remote_block,
          address: address,
          remote_tx: remote_tx,
          remote_tx_output: remote_tx_output,
          block_index: 2000,
        )
        described_class.execute(
          remote_block: remote_block_update,
          address: address,
          remote_tx: remote_tx,
          remote_tx_output: remote_tx_output,
          block_index: 2000,
        )
        tx = Tx.find_by(tx_id: remote_tx["txid"])
        expect(tx.confirmations).to eq 2
      end
    end

  end
end
