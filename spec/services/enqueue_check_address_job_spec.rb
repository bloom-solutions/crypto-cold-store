require 'rails_helper'

RSpec.describe EnqueueCheckAddressJob do

  let!(:address) { create(:address, coin: "btc", address: "abc123") }
  let!(:tx_1) { create(:tx, tx_hash: "txhash1", address: address) }
  let!(:tx_2) { create(:tx, tx_hash: "txhash2", address: address) }

  it "enqueues the job to check the address" do
    described_class.execute(address: address)

    expect(CheckAddressJob).to have_enqueued_sidekiq_job(
      "btc",
      "abc123",
      %w(txhash1 txhash2),
    )
  end

end
