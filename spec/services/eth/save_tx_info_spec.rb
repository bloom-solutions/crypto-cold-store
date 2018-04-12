require 'rails_helper'

module Eth
  RSpec.describe SaveTxInfo do

    let(:remote_tx) do
      {
        "blockNumber"=>"0x2d0e92", # 2952850
        "hash"=>"0xf2c46bdc27b960fcdc8073d6765b97b6aa1484e939e420ef07d21a91efb7614b",
        # not everything
        "to"=>"0xa90c34c824687f74ed24406e7621706130f8ef15",
        "transactionIndex"=>"0xb",
        "value"=> 1_100_000_000_000_000_000.to_s(16),
      }
    end
    let!(:address) do
      create(:address, {
        coin: "eth",
        address: "0xa90c34c824687f74ed24406e7621706130f8ef15",
      })
    end
    let(:block) do
      create(:block, coin: "eth", height: 2952850, confirmations: 2)
    end

    context "tx exists" do
      let!(:tx) do
        create(:tx, {
          address: address,
          confirmations: 2,
          amount: 1.1,
          tx_id: remote_tx["to"],
        })
      end

      it "updates the tx" do
        resulting_ctx = described_class.execute({
          address: address,
          remote_tx: remote_tx,
          block: block,
        })
        expect(resulting_ctx.tx.confirmations).to eq 2
      end
    end

    context "tx does not exist" do
      it "saves the tx" do
        resulting_ctx = described_class.execute({
          address: address,
          remote_tx: remote_tx,
          block: block,
        })
        tx = resulting_ctx.tx
        expect(tx.confirmations).to eq 2
        expect(tx.amount).to eq 1.1
        expect(tx.address).to eq address
        expect(tx.tx_id).to eq remote_tx["hash"]
        expect(tx.block).to eq block
      end
    end

    context "block does not exist (tx is unconfirmed)" do
      it "does not assign the values related to the block" do
        resulting_ctx = described_class.execute({
          address: address,
          remote_tx: remote_tx,
        })
        tx = resulting_ctx.tx
        expect(tx.confirmations).to be_zero
        expect(tx.amount).to eq 1.1
        expect(tx.address).to eq address
        expect(tx.tx_id).to eq remote_tx["hash"]
        expect(tx.block).to be_nil
      end
    end

  end
end
