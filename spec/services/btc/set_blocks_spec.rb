require 'rails_helper'

module Btc
  RSpec.describe SetBlocks do

    it "sets blocks to btc blocks" do
      resulting_ctx = described_class.execute
      expect(resulting_ctx.blocks.to_sql).to eq Block.btc.to_sql
    end

  end
end
