require 'rails_helper'

module Eth
  RSpec.describe SetBlocks do

    it "sets blocks to eth blocks" do
      resulting_ctx = described_class.execute
      expect(resulting_ctx.blocks.to_sql).to eq Block.eth.to_sql
    end

  end
end
