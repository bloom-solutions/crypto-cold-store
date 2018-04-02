require 'rails_helper'

RSpec.describe InitEthereumClient do

  it "initializes the ethereum client" do
    resulting_ctx = described_class.execute
    ethereum_client = resulting_ctx.ethereum_client
    expect(ethereum_client).to be_a(Ethereum::HttpClient)
    expect(ENV["ETHEREUM_HOST"]).to include ethereum_client.host
  end

end
