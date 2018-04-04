require 'rails_helper'

module Eth
  RSpec.describe GetCurrentBlock, vcr: {record: :once} do

    let(:ethereum_client) { InitEthereumClient.execute.ethereum_client }

    it "fetches the current block number" do
      resulting_ctx = described_class.execute(ethereum_client: ethereum_client)
      current_block_number = resulting_ctx.current_block_number
      expect(current_block_number).to be_an Integer
      expect(current_block_number).to be > 2952868 # latest block as of writing
    end

  end
end
