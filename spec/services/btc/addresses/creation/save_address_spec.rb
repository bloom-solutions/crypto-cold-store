require 'rails_helper'

module Btc
  module Addresses
    module Creation
      RSpec.describe SaveAddress do

        it "saves the Address with the public_address and code" do
          resulting_ctx = described_class.execute(
            public_address: "1JSG2TcTFh7yEhkF4WsNj86hnMmU65SrAF",
            code: "123abc",
          )

          expect(resulting_ctx.address).to be_present
          address = resulting_ctx.address
          expect(address.address).to eq "1JSG2TcTFh7yEhkF4WsNj86hnMmU65SrAF"
          expect(address.code).to eq "123abc"
          expect(address).to be_btc
        end

      end
    end
  end
end
