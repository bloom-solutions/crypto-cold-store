require 'rails_helper'

module Btc
  RSpec.describe SyncBlocksJob do

    it "inherits from ApplicationJob" do
      expect(described_class < ApplicationJob).to be true
    end

    it "is unique until_executed" do
      expect(described_class.sidekiq_options["unique"]).to eq :until_executed
    end

    it "logs on conflict" do
      expect(described_class.sidekiq_options["on_conflict"]).to eq :log
    end

    it "delegates work to SyncBlocks" do
      expect(SyncBlocks).to receive(:call).with(%w(h1))
      described_class.new.perform(%w(h1))
    end

  end
end
