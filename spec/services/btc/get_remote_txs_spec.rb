require 'rails_helper'

module Btc
  RSpec.describe GetRemoteTxs do

    context "remote block has txs" do
      let(:remote_block) { { "tx" => [{"txid" => "abc"}] } }

      it "sets the tx of the remote_block in the context" do
        resulting_ctx = described_class.execute(remote_block: remote_block)
        expect(resulting_ctx.remote_txs).to eq [{"txid" => "abc"}]
      end
    end

    context "remote block has no txs" do
      let(:remote_block) { { "tx" => nil } }

      it "sets the tx of the remote_block in the context" do
        resulting_ctx = described_class.execute(remote_block: remote_block)
        expect(resulting_ctx.remote_txs).to be_empty
      end
    end

  end
end
