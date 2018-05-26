require 'rails_helper'

module Btc
  module Addresses
    module Creation
      RSpec.describe GenAddress do

        let(:master_public_key) do
          # These are from Electrum
          # chain...
          mpks = [
            "xpub6D4K8Hb6sMZwwtbk6p94RnRewTb6PykJc1zZwB3GUozGSNXLnTdL2T8uXRehiD9d5Dis3bDpJCvR3pFZcYUu2xpPj5Z73oFNUUQKwkFTewo",
            "xpub661MyMwAqRbcGHY2QrfyiUyvSv93zCQN8Cv3eXFB3ivnq7SQ6TLUJueJnGZKR8r8CQ5cLsGrr9D71uwAW9RLKqFyUybARtbbqg1kiHopBsZ",
          ]
          # but since we want the xpub of the receiving chain...
          mpks.map do |mpk|
            BTC::Keychain.new(extended_key: mpk).derived_keychain("0").xpub
          end
        end
        let(:address_1) { "3Dur7FTopK9jAUNSmLyGggMQc1nsnL2Cv6" }

        it "generates an address based on the keychain[address_index]" do
          resulting_ctx = described_class.execute(
            master_public_key: master_public_key,
            signatures_required: 1,
            address_index: 1,
          )
          expect(resulting_ctx.public_address).to eq address_1
        end

      end
    end
  end
end
