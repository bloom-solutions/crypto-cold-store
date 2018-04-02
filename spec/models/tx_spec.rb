require 'rails_helper'

RSpec.describe Tx do

  describe "associations" do
    it { is_expected.to belong_to(:address) }
  end

  describe ".with_confirmations_less_than" do
    let!(:tx_1) { create(:tx, confirmations: 11) }
    let!(:tx_2) { create(:tx, confirmations: 11) }
    let!(:tx_3) { create(:tx, confirmations: 9) }

    it "returns txs with confirmations less than the given number" do
      expect(described_class.with_confirmations_less_than(12)).
        to match_array([tx_1, tx_2, tx_3])
      expect(described_class.with_confirmations_less_than(11)).
        to match_array([tx_3])
      expect(described_class.with_confirmations_less_than(9)).
        to be_empty
    end
  end

  describe ".of_coin" do
    let!(:btc_address) { create(:address, coin: "btc") }
    let!(:btc_tx) { create(:tx, address: btc_address) }
    let!(:eth_address) { create(:address, coin: "eth") }
    let!(:eth_tx) { create(:tx, address: eth_address) }

    it "returns the txs of a coin type" do
      expect(described_class.of_coin(:btc)).to match_array([btc_tx])
      expect(described_class.of_coin("btc")).to match_array([btc_tx])
      expect(described_class.of_coin("eth")).to match_array([eth_tx])
    end
  end

end
