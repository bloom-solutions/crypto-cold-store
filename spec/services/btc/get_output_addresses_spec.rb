require 'rails_helper'

module Btc
  RSpec.describe GetOutputAddresses do

    let(:remote_txs) do
      [
        {
          "vout" => [
            {
              "scriptPubKey" => {
                "type" => "pubkeyhash",
                "addresses" => ["addr1"],
              }
            }
          ]
        },
        {
          "vout" => [
            {
              "scriptPubKey" => {
                "type" => "pubkeyhash",
                "addresses" => ["addr2"],
              }
            }
          ]
        }
      ]
    end

    it "sets the output_addresses found in remote_txs" do
      resulting_ctx = described_class.(remote_txs: remote_txs)

      expect(resulting_ctx.output_addresses).to match_array(%w(addr1 addr2))
    end

  end
end
