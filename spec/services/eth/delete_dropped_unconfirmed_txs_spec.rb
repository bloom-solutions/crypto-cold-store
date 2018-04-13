require 'rails_helper'

module Eth
  RSpec.describe DeleteDroppedUnconfirmedTxs do

    let(:address_eth) { create(:address, coin: "eth") }
    let(:address_btc) { create(:address, coin: "btc") }
    let!(:tx_1) { create(:tx, address: address_btc, confirmations: 0) }
    let!(:tx_2) { create(:tx, address: address_eth, confirmations: 0) }
    let!(:tx_3) { create(:tx, address: address_eth, confirmations: 1) }
    let!(:tx_4) { create(:tx, address: address_eth, confirmations: 0) }
    let(:pending_remote_txs) { [{"hash" => tx_4.tx_id}] }

    it "deletes the unconfirmed txs that have been dropped from the list of pending txs" do
      resulting_ctx = described_class.execute(remote_txs: pending_remote_txs)

      expect(::Tx.find_by(tx_id: tx_1.tx_id)).to be_present
      expect(::Tx.find_by(tx_id: tx_2.tx_id)).to be_nil
      expect(::Tx.find_by(tx_id: tx_3.tx_id)).to be_present
      expect(::Tx.find_by(tx_id: tx_4.tx_id)).to be_present
    end

  end
end
