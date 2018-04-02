require 'rails_helper'

module Eth
  RSpec.describe GetRemoteTxs do

    let(:remote_txs) do
      [
        {
          "blockHash"=>"0xad1aa0382fb117212c1ea272829280284dee361d0a83f222eac0c5a99797cd22",
          "blockNumber"=>"0x2d0e92",
          "from"=>"0x35451d25e83a78978b1b902b7eb3a14021371f7c",
          "hash"=>"0xf2c46bdc27b960fcdc8073d6765b97b6aa1484e939e420ef07d21a91efb7614b",
          # not everything
          "to"=>"0xa90c34c824687f74ed24406e7621706130f8ef15",
          "transactionIndex"=>"0x0",
          "value"=>"0x0",
          "v"=>"0x1b",
          "r"=>"0x4b8a3552eed2a7e4c0e0030cd4782baa8ad32f170889b527d8ff149a44a8ed5c",
          "s"=>"0x649b47263b24a7a3ecb3f177a9ea5f1ad639315d176b6722804e98b048ee56dd"
        }
      ]
    end
    let(:remote_block) { { "transactions" => remote_txs } }

    it "sets the remote_txs based on the remote_block in the context" do
      resulting_ctx = described_class.execute(remote_block: remote_block)
      expect(resulting_ctx.remote_txs).to eq remote_txs
    end

  end
end
