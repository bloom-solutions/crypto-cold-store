require 'rails_helper'

module Btc
  RSpec.describe AddressGenerator do

    describe "initialization" do
      context "given a single xpub" do
        let(:xpub) do
          "xpub6DY7Fqdz98GSsFDN96Levia3PwnREqhFER5RtKwiwrDzBJpEtGX5VcZdPrLgJriUfStunLmWYxrHM6XPygEJhrXZGrVh1fVZc2AQkAVPf9n"
        end

        it "initializes a generator" do
          generator = described_class.new(xpub: xpub)
          expect(generator.xpub).to eq [xpub]
        end
      end

      context "given a single xpub in an array" do
        let(:xpub) do
          [
            "xpub6DY7Fqdz98GSsFDN96Levia3PwnREqhFER5RtKwiwrDzBJpEtGX5VcZdPrLgJriUfStunLmWYxrHM6XPygEJhrXZGrVh1fVZc2AQkAVPf9n"
          ]
        end

        it "initializes a generator" do
          generator = described_class.new(xpub: xpub)
          expect(generator.xpub).to eq xpub
        end
      end

      context "given an array of xpub" do
        let(:xpub) do
          [
            "xpub6DY7Fqdz98GSsFDN96Levia3PwnREqhFER5RtKwiwrDzBJpEtGX5VcZdPrLgJriUfStunLmWYxrHM6XPygEJhrXZGrVh1fVZc2AQkAVPf9n",
            "xpub6DfZs3n92pxJ3LCBf7bfgbyrECteT8PWmee5UpZhG1aBurdF5t1Tu2jxdnCBXETztHu6YkJ8Hin8t8qwPsh3YScNX3dLxduNSaevLF3KLpq",
            "xpub6EfBrTeLn8nFHBQN4v53LYdGaZjCMXvF1nLsCUvT8n1rjHppXK4p2xJFoupGbD2BnHCHcMxp3NPjzA25EDajwxZTR5SDuS6XCi9ahfMhzXx",
          ]
        end

        it "initializes a generator" do
          generator = described_class.new(xpub: xpub, signatures_required: "2")
          expect(generator.xpub).to eq xpub
          expect(generator.signatures_required).to eq 2
        end

        context "without signatures_required specified" do
          it "raises an error" do
            expect { described_class.new(xpub: xpub, signatures_required: nil) }.
              to raise_error(ArgumentError, "because xpub is an array of multiple keys, signatures_required must be a valid number")
            expect { described_class.new(xpub: xpub, signatures_required: 0) }.
              to raise_error(ArgumentError, "because xpub is an array of multiple keys, signatures_required must be a valid number")
          end
        end

        context "signatures_required is more than the number of xpub" do
          it "raises an error" do
            expect { described_class.new(xpub: xpub, signatures_required: 4) }.
              to raise_error(ArgumentError, "signatures_required must be less or equal to the number of xpub")
          end
        end
      end
    end

    describe "#address" do
      context "single extended key" do
        let(:generator) { described_class.new(xpub: xpub) }
        let(:xpub) do
          "xpub6DY7Fqdz98GSsFDN96Levia3PwnREqhFER5RtKwiwrDzBJpEtGX5VcZdPrLgJriUfStunLmWYxrHM6XPygEJhrXZGrVh1fVZc2AQkAVPf9n"
        end

        it "generates an address at the given index" do
          expect(generator.address(0)).to eq "1APpMstoe5usBVHLqVe5vrWtHWqT5bW7Gi"
          expect(generator.address(6)).to eq "1LsknoMhjq5Gia8eVEGixs95LdKkwWhDs7"
          expect(generator.address(19)).to eq "12JPDKAjPDU5pmWYxYed64XDKLKPTrqgLi"
        end
      end

      context "multiple extended keys" do
        let(:xpub) do
          # These are from Electrum
          mpks = [
            "xpub6D4K8Hb6sMZwwtbk6p94RnRewTb6PykJc1zZwB3GUozGSNXLnTdL2T8uXRehiD9d5Dis3bDpJCvR3pFZcYUu2xpPj5Z73oFNUUQKwkFTewo",
            "xpub661MyMwAqRbcGHY2QrfyiUyvSv93zCQN8Cv3eXFB3ivnq7SQ6TLUJueJnGZKR8r8CQ5cLsGrr9D71uwAW9RLKqFyUybARtbbqg1kiHopBsZ",
          ]
          # but since we want the xpub of the receiving chain and not change
          # chain...
          mpks.map do |mpk|
            BTC::Keychain.new(extended_key: mpk).derived_keychain("0").xpub
          end
        end
        let(:generator) do
          described_class.new(xpub: xpub, signatures_required: 1)
        end

        it "generates an address at the given index for the required number of signatures" do
          expect(generator.address(0)).to eq "32Zt24PnJSjhgVvBKoZiyqPz26AmgUo1sV"
          expect(generator.address(18)).to eq "3CwgJ7iYBWufLpwgsGKikjEH5YL38CAfz3"
        end
      end
    end

  end
end
