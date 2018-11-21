require 'rails_helper'

module Eth
  RSpec.describe GetPendingTxs, vcr: {record: :once} do

    let(:client) { InitEthereumClient.execute.ethereum_client }

    # NOTE when re-recording the cassette, this spec requires there's
    # *something* in the testnet's pending transactions
    it "sets the pending transactions as remote_txs" do
      resulting_ctx = described_class.execute(ethereum_client: client)
      remote_txs = resulting_ctx.remote_txs

      expect(remote_txs).to_not be_empty
      expect(remote_txs.first["blockHash"].to_i(16)).to be_zero
    end

    context "EOFError is raised" do
      it "fails and stops processing" do
        expect(client).to receive(:txpool_content).and_raise(EOFError)

        result = described_class.execute(remote_txs: [], ethereum_client: client)

        expect(result).to be_failure
        expect(result).to be_stop_processing
      end
    end

  end
end
