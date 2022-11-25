require 'rails_helper'

module Eth
  module Addresses
    module Creation
      module Bip44Wallet
        RSpec.describe GenAddress do

          let(:bip44_wallet) do
            Bip44::Wallet.from_xpub("wM5uZBV4LrG2YawGW8wBUgSmGPyA8WTsfQFBeSjWV2uN4iFHxgRzg9Xoku1kkHSoq67JKz3hapa9VfAK4Co2Mn5ZdmP63tHqP4BiXqL5VqzCGUqG")
          end

          xit "generates the address from the bip44_wallet and the address_index" do
            resulting_ctx = described_class.execute({
              bip44_wallet: bip44_wallet,
              address_index: 0,
            })
            expect(resulting_ctx.public_address).
              to eq "0x9c282c8602a10E30baa14850676d728205C0B7D0".downcase

            resulting_ctx = described_class.execute({
              bip44_wallet: bip44_wallet,
              address_index: 4,
            })
            expect(resulting_ctx.public_address).
              to eq "0x86D7984843C3079eaf467Ef73eDA7a79621d867B".downcase
          end
        end

      end
    end
  end
end
