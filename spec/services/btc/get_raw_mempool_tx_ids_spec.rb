require 'rails_helper'

module Btc
  RSpec.describe GetRawMempoolTxIds, vcr: {record: :once} do

    let(:bitcoiner_client) { InitBitcoinerClient.execute.bitcoiner_client }

    it "sets tx_ids to the rawmempool txids" do
      resulting_ctx = described_class.execute(bitcoiner_client: bitcoiner_client)
      tx_ids = resulting_ctx.tx_ids

      expect(tx_ids).to_not be_empty
      expect(tx_ids.first).to be_a String
    end

  end
end
