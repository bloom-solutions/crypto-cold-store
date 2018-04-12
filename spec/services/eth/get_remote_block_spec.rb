require 'rails_helper'

module Eth
  RSpec.describe GetRemoteBlock, vcr: {record: :once} do

    let(:ethereum_client) { InitEthereumClient.execute.ethereum_client }

    it "sets the remote_block based on the block_height in the context" do
      resulting_ctx = described_class.execute(
        ethereum_client: ethereum_client,
        block_height: 2952850,
      )
      expect(resulting_ctx.remote_block["number"].to_i(16)).
        to eq 2952850
    end

  end
end
