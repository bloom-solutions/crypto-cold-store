require 'rails_helper'

module Btc
  module Addresses
    module Creation
      module Btcruby
        RSpec.describe GenAddress do

          let(:master_public_key) do
            [
              "xpub6DY7Fqdz98GSsFDN96Levia3PwnREqhFER5RtKwiwrDzBJpEtGX5VcZdPrLgJriUfStunLmWYxrHM6XPygEJhrXZGrVh1fVZc2AQkAVPf9n",
              "xpub6DfZs3n92pxJ3LCBf7bfgbyrECteT8PWmee5UpZhG1aBurdF5t1Tu2jxdnCBXETztHu6YkJ8Hin8t8qwPsh3YScNX3dLxduNSaevLF3KLpq",
              "xpub6FFgmnaotx9GP3XkdK8oS8j3ExWBXXGdJ5LeWYmCHUAppaG85HPm4QRGrtowZJfwzDqjKkp1kc5mzUwa2W1PEicuynzC45myaa4vVG7bNJy",
            ]
          end
          let(:address_18) { "3GAGdkU6awG9aiDyiyrmrjvo8tpHbab5Ff" }

          it "generates an address based on the keychain[address_index]" do
            resulting_ctx = described_class.execute(
              master_public_key: master_public_key,
              signatures_required: 2,
              address_index: 18,
            )
            expect(resulting_ctx.public_address).to eq address_18
          end

        end
      end
    end
  end
end
