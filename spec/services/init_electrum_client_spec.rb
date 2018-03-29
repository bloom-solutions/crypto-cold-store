require 'rails_helper'

RSpec.describe InitElectrumClient do

  it "sets an electrum client in the context" do
    ctx = described_class.execute
    expect(ctx.electrum_client).to be_an ElectrumRpcJsonClient::Client
    expected_host = Addressable::URI.heuristic_parse(ENV["ELECTRUM_HOST"])
    expected_host.user = ENV["ELECTRUM_RPC_USER"]
    expected_host.password = ENV["ELECTRUM_RPC_PASSWORD"]
    expect(ctx.electrum_client.host).to eq expected_host.to_s
  end

end
