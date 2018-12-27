require 'rails_helper'

module Eth
  RSpec.describe SetBlocks do

    it "sets blocks to eth blocks" do
      resulting_ctx = described_class.execute
      expected_sql = Block.eth.
        with_confirmations_less_than(described_class::MAX_CONFS).to_sql
      expect(resulting_ctx.blocks.to_sql).to eq expected_sql
    end

  end
end
