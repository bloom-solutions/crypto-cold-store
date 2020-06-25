require 'rails_helper'

RSpec.describe "/api/v1/deposit_details" do

  context "bitcoin" do
    it "returns the deposit details for the unique customer code", vcr: {record: :once} do
      get api_v1_deposit_detail_path, params: { coin: "btc", code: "abc" }

      expect(response).to be_success
      json = JSON.parse(response.body).with_indifferent_access
      address_1 = json[:address]
      expect(address_1).to be_present
      expect(address_1.size).to be >= 26
      expect(address_1.size).to be <= 35
    end
  end

  context "ethereum" do
    it "returns the deposit details for the unique customer code" do
      get api_v1_deposit_detail_path, params: { coin: "eth", code: "abc" }

      expect(response).to be_success
      json = JSON.parse(response.body).with_indifferent_access
      address_1 = json[:address]
      expect(address_1).to be_present
      expect(address_1.size).to be 42
    end
  end

  context "monero" do
    it "returns the deposit details for the unique customer code" do
      get api_v1_deposit_detail_path, params: { coin: "xmr", code: "abc" }

      expect(response).to be_success
      json = JSON.parse(response.body).with_indifferent_access
      address_1 = json[:address]
      expect(address_1).to be_present
      expect(address_1.size).to be 106
    end

  end

end
