require 'rails_helper'

module Btc
  RSpec.describe ImportAddressJob do

    it "inherits from ApplicationJob" do
      expect(described_class < ApplicationJob).to be true
    end

    it "delegates work to #{Btc::ImportAddress}" do
      expect(Btc::ImportAddress).to receive(:call).with("abc")
      described_class.new.perform("abc")
    end

  end
end
