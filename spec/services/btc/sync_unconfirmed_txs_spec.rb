require 'rails_helper'

module Btc
  RSpec.describe SyncUnconfirmedTxs do

    # NOTE
    # - when re-recording the cassette, this spec requires there's
    # *something* in the testnet's pending transactions
    # - the address below must be changed to an address that is the recipient of
    # a tx in the pending txs
    let!(:address) do
      create(:address, {
        coin: "btc",
        address: "mxosQ4CvQR8ipfWdRktyB3u16tauEdamGc",
      })
    end

    it "syncs the unconfirmed btc txs", vcr: {record: :once} do
      described_class.()
      txs = ::Tx.of_coin(:btc).where(confirmations: 0)
      expect(txs).to_not be_empty
      expect(txs.pluck(:block_hash).uniq).to match_array([nil])
    end

  end
end
