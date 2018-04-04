require 'rails_helper'

module Btc
  RSpec.describe SaveTxInfo do

    let(:remote_tx) do
      {
        "involvesWatchonly" => true,
        "account" => "",
        "address" => "muhtvdmsnbQEPFuEmxcChX58fGvXaaUoVt",
        "category" => "receive",
        "amount" => 0.23400000,
        "label" => "",
        "vout" => 0,
        "confirmations" => 657517,
        "blockhash" => "000000009a15ea8d27ed43c02d49a6b31c4b9d1a67739ccc320752f855f2401f",
        "blockindex" => 158,
        "blocktime" => 1452217559,
        "txid" => "69893d0d726a748a6948059a011d0380bf59a822ef1927cb8a8f4bd4acc6a886",
        "walletconflicts" => [],
        "time" => 1452217559,
        "timereceived" => 1522380759,
        "bip125-replaceable" => "no"
      }
    end
    let!(:address) do
      create(:address, coin: "btc", address: remote_tx["address"])
    end

    context "tx does not exist locally" do
      it "saves the tx" do
        tx_count = Tx.count
        tx = described_class.execute(address: address, remote_tx: remote_tx).tx
        expect(Tx.count).to eq tx_count+1
        expect(tx.tx_id).to eq "69893d0d726a748a6948059a011d0380bf59a822ef1927cb8a8f4bd4acc6a886"
        expect(tx.confirmations).to eq 657517
        expect(tx.amount).to eq 0.23400000
        expect(tx.block_index).to eq 158
      end
    end

    context "tx exists locally" do
      let(:remote_tx_update) do
        {
          "involvesWatchonly" => true,
          "account" => "",
          "address" => "muhtvdmsnbQEPFuEmxcChX58fGvXaaUoVt",
          "category" => "receive",
          "amount" => 0.23400000,
          "label" => "",
          "vout" => 0,
          "confirmations" => 657518,
          "blockhash" => "000000009a15ea8d27ed43c02d49a6b31c4b9d1a67739ccc320752f855f2401f",
          "blockindex" => 158,
          "blocktime" => 1452217559,
          "txid" => "69893d0d726a748a6948059a011d0380bf59a822ef1927cb8a8f4bd4acc6a886",
          "walletconflicts" => [],
          "time" => 1452217559,
          "timereceived" => 1522380759,
          "bip125-replaceable" => "no"
        }
      end

      it "updates the tx" do
        described_class.execute(address: address, remote_tx: remote_tx)
        described_class.execute(address: address, remote_tx: remote_tx_update)
        tx = Tx.find_by(tx_id: remote_tx["txid"])
        expect(tx.confirmations).to eq 657518
      end
    end

  end
end
