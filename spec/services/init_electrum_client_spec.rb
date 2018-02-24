require 'rails_helper'

RSpec.describe InitElectrumClient do

  it "sets an electrum client in the context" do
    ctx = described_class.execute
    expect(ctx.electrum_client).to be_an ElectrumRpcJsonClient::Client
    expect(ctx.electrum_client.host).to eq ENV["ELECTRUM_HOST"]
  end

end
