require 'rails_helper'

RSpec.describe Block do

  describe "associations" do
    it do
      is_expected.to have_many(:txs).
        with_foreign_key(:block_hash).
        with_primary_key(:block_hash)
    end
  end

  describe ".with_confirmations_less_than" do
    let!(:block_1) { create(:block, confirmations: 11) }
    let!(:block_2) { create(:block, confirmations: 11) }
    let!(:block_3) { create(:block, confirmations: 9) }

    it "returns blocks with confirmations less than the given number" do
      expect(described_class.with_confirmations_less_than(12)).
        to match_array([block_1, block_2, block_3])
      expect(described_class.with_confirmations_less_than(11)).
        to match_array([block_3])
      expect(described_class.with_confirmations_less_than(9)).
        to be_empty
    end
  end

end
