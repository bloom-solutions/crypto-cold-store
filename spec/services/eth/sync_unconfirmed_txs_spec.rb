require 'rails_helper'

module Eth
  RSpec.describe SyncUnconfirmedTxs, vcr: {record: :once} do

    # NOTE
    # - when re-recording the cassette, this spec requires there's
    # *something* in the testnet's pending transactions
    # - the address below must be changed to an address that is the recipient of
    # a tx in the pending txs
    let!(:address) do
      create(:address, {
        coin: "eth",
        address: "0xff2b5d4114190bb6447dbae098096fd274029535",
      })
    end

    it "syncs eth's pending transactions" do
      described_class.()
      txs = ::Tx.of_coin(:eth).where(confirmations: 0)
      expect(txs).to_not be_empty
      expect(txs.pluck(:block_hash).uniq).to match_array([nil])
    end

  end
end
