require 'rails_helper'

module Btc
  RSpec.describe SetBlocks do

    it "sets blocks to btc blocks" do
      resulting_ctx = described_class.execute
      expected_sql = Block.btc.
        with_confirmations_less_than(described_class::MAX_CONFS).to_sql
      expect(resulting_ctx.blocks.to_sql).to eq expected_sql
    end

  end
end
