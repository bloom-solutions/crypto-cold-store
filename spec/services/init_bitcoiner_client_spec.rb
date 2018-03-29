require 'rails_helper'

RSpec.describe InitBitcoinerClient do

  it "places bitcoiner_client in the ctx" do
    resulting_ctx = described_class.execute
    expect(resulting_ctx.bitcoiner_client).to be_a Bitcoiner::Client
    expect(resulting_ctx.bitcoiner_client.endpoint).to eq ENV["BITCOIND_HOST"]
  end

end
