require 'rails_helper'

module Btc
  module Addresses
    module Creation
      module Btcruby
        RSpec.describe GenAddress do

          let(:master_public_key) do
            "xpub6FMbbkESWrcdwWdJgfW4qPMF8JhjTbLgKoSjKofd6X5f1rjz1qm3N3nQ4DfFcz8SHPNrVq4RzfmvRG488LPY7d59r4Cp4bV7e7G6zvUA8MU"
          end
          let(:keychain) { BTC::Keychain.new(xpub: master_public_key) }
          let(:address_0) { "1FTwdEtxdswwLmVeyAn8Rx8nVCVziRtVDs" }
          let(:address_3) { "1HrCwg2zpU8yqmndv2upPDXWKUmJkowqAQ" }

          it "generates an address based on the keychain[address_index]" do
            resulting_ctx = described_class.execute(
              keychain: keychain,
              address_index: 0,
            )
            expect(resulting_ctx.public_address).to eq address_0

            resulting_ctx = described_class.execute(
              keychain: keychain,
              address_index: 3,
            )
            expect(resulting_ctx.public_address).to eq address_3
          end

        end
      end
    end
  end
end
