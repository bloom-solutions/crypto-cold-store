require 'rails_helper'

RSpec.describe SyncMissingBlocksJob do

  it "inherits from ApplicationJob" do
    expect(described_class < ApplicationJob).to be true
  end

  it "is unique until_and_while_executing" do
    expect(described_class.sidekiq_options["unique"])
      .to eq :until_and_while_executing
  end

  it "logs on conflict" do
    expect(described_class.sidekiq_options["on_conflict"]).to eq :log
  end

  %w(btc eth).each do |coin|
    # NOTE: not all Block::COINS are synced, yet
    context "given the arg `#{coin}`" do
      it "delegates work to #{coin.classify}::SyncMissingBlocks" do
        expect(SyncMissingBlocks).to receive(:call).with(coin)
        described_class.new.perform(coin)
      end
    end
  end

end
