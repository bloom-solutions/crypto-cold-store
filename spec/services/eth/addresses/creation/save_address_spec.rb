require 'rails_helper'

module Eth
  module Addresses
    module Creation
      RSpec.describe SaveAddress do

        context "address exists" do
          before do
            create(:address, coin: "eth", address: "abc", code: "123")
          end

          it "does nothing" do
            resulting_ctx = described_class.execute({
              public_address: "abc",
              code: "123",
            })
            expect(resulting_ctx.address.address).to eq "abc"
          end
        end

        context "address does not exist" do
          it "creates the address" do
            resulting_ctx = described_class.execute({
              public_address: "678",
              code: "123",
            })

            address = resulting_ctx.address
            expect(address.code).to eq "123"
            expect(address.address).to eq "678"
          end
        end

      end
    end
  end
end
