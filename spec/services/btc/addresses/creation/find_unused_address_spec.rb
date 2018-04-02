require 'rails_helper'

module Btc
  module Addresses
    module Creation
      module Electrum
        RSpec.describe FindUnusedAddress do

          let(:client) { InitElectrumClient.execute.electrum_client }

          describe "finding an address that has been seen before" do
            before do
              create(:address, coin: "btc", address: "addr1")
              create(:address, coin: "btc", address: "addr2")
            end

            it "keeps looking until it finds an unused one" do
              expect(Electrum::CreateNewAddress).to receive(:call).
                with(electrum_client: client).
                and_return(*%w(addr1 addr2 addr3))

              resulting_ctx = described_class.execute(electrum_client: client)
              expect(resulting_ctx.public_address).to eq "addr3"
            end
          end

          describe "finding an address not seen before" do
            it "returns the found address" do
              expect(Electrum::CreateNewAddress).to receive(:call).
                with(electrum_client: client).
                and_return("addr")

              resulting_ctx = described_class.execute(electrum_client: client)
              expect(resulting_ctx.public_address).to eq "addr"
            end
          end

        end
      end
    end
  end
end
