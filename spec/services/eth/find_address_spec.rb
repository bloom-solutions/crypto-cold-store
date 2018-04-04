require 'rails_helper'

module Eth
  RSpec.describe FindAddress do

    let(:remote_tx) do
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
    end

    context "address exists locally" do
      let!(:address_other) do
        create(:address, {
          coin: "ltc",
          address: "0xa90c34c824687f74ed24406e7621706130f8ef15",
        })
      end
      let!(:address_eth) do
        create(:address, {
          coin: "eth",
          address: "0xa90c34c824687f74ed24406e7621706130f8ef15",
        })
      end

      it "sets the address of the remote_tx" do
        resulting_ctx = described_class.execute(remote_tx: remote_tx)
        expect(resulting_ctx.address).to eq address_eth
      end
    end

    context "address does not exist" do
      it "skips the rest of the steps" do
        resulting_ctx = described_class.execute(remote_tx: remote_tx)
        expect(resulting_ctx).to be_skip_remaining
      end
    end

  end
end
