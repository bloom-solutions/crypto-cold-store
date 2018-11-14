require 'rails_helper'

  RSpec.describe SyncUnconfirmedTxsJob do

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

    # Not all coins in Block::COINS are synced, yet
    %w(btc eth).each do |coin|
      context "given arg of #{coin}" do
        it "delegates work to #{coin.classify}::SyncUnconfirmedTxs" do
          target_klass =
            coin.classify.constantize.const_get("SyncUnconfirmedTxs")
          expect(target_klass).to receive(:call)
          described_class.new.perform(coin)
        end
      end
    end

  end
