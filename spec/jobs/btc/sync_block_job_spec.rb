require 'rails_helper'

module Btc
  RSpec.describe SyncBlockJob do

    it "inherits from ApplicationJob" do
      expect(described_class < ApplicationJob).to be true
    end

    it "is unique until_and_while_executing" do
      expect(described_class.sidekiq_options["unique"])
        .to eq :until_and_while_executing
    end

    it "delegates work to #{Btc::SyncBlock}" do
      expect(Btc::SyncBlock).to receive(:call).with(4)
      described_class.new.perform(4)
    end

  end
end
