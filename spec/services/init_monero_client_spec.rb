require 'rails_helper'

RSpec.describe InitMoneroClient do

  it "initializes the monero client" do
    resulting_ctx = described_class.execute
    monero_client = resulting_ctx.monero_client
    expect(monero_client).to be(RPC)
    expect(ENV["XMR_HOST"]).to include RPC.config.host
  end
end
