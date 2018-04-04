require 'rails_helper'

module Eth
  module Addresses
    module Creation
      module Bip44Wallet
        RSpec.describe GetAddressIndex do

          before do
            create(:address, coin: "eth")
            create(:address, coin: "ltc")
            create(:address, coin: "eth")
          end
          it "sets the address_index to the index in the bip44_wallet to use" do
            resulting_ctx = described_class.execute
            expect(resulting_ctx.address_index).to eq 2
          end

        end
      end
    end
  end
end
