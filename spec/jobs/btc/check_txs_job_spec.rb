require 'rails_helper'

module Btc
  RSpec.describe CheckTxsJob do

    it "inherits from ApplicationJob" do
      expect(described_class < ApplicationJob).to be true
    end

    it "delegates work to #{Btc::CheckTxs}" do
      expect(CheckTxs).to receive(:call)
      described_class.new.perform
    end

  end
end
