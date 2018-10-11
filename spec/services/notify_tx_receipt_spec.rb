require 'rails_helper'

RSpec.describe NotifyTxReceipt do

  let(:address) { create(:address, coin: "btc", address: "abc", code: "123") }
  let(:tx) do
    create(:tx, tx_id: "txid", address: address, confirmations: 2, amount: 3.14)
  end

  it "publishes that the tx has been received" do
    described_class.execute(tx: tx)
    messages = MessageBus.backlog described_class::CHANNEL, 0
    expect(messages.count).to be > 0
    data = messages.last.data
    expect(data["coin"]).to eq "btc"
    expect(data["code"]).to eq "123"
    expect(data["tx_id"]).to eq "txid"
    expect(data["address"]).to eq "abc"
    expect(data["amount"]).to eq "3.14"
    expect(data["confirmations"]).to eq 2
  end

end
