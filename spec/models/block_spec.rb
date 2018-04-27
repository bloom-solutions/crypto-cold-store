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

  describe ".with_height_greater_than_or_equal_to" do
    let!(:block_1) { create(:block, height: 12) }
    let!(:block_2) { create(:block, height: 11) }
    let!(:block_3) { create(:block, height: 9) }

    it "returns the blocks with the height greater than or equal to the integer" do
      expect(described_class.with_height_greater_than_or_equal_to(11)).
        to match_array([block_1, block_2])
      expect(described_class.with_height_greater_than_or_equal_to(12)).
        to match_array([block_1])
      expect(described_class.with_height_greater_than_or_equal_to(2)).
        to match_array([block_1, block_2, block_3])
    end

    it "aliases .with_height_gteq" do
      expect(described_class.with_height_gteq(11)).
        to match_array([block_1, block_2])
    end
  end

  describe ".with_height_greater_than_or_equal_to" do
    let!(:block_1) { create(:block, height: 12) }
    let!(:block_2) { create(:block, height: 11) }
    let!(:block_3) { create(:block, height: 9) }

    it "returns the blocks with the height less than or equal to the integer" do
      expect(described_class.with_height_less_than_or_equal_to(11)).
        to match_array([block_2, block_3])
      expect(described_class.with_height_less_than_or_equal_to(12)).
        to match_array([block_1, block_2, block_3])
      expect(described_class.with_height_less_than_or_equal_to(2)).to be_empty
    end

    it "aliases .with_height_lteq" do
      expect(described_class.with_height_lteq(11)).
        to match_array([block_2, block_3])
    end
  end

end
