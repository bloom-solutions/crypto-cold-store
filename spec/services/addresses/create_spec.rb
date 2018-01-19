require 'rails_helper'

module Addresses
  RSpec.describe Create do

    Address.coins.keys.each do |key|
      context "given #{key}" do
        it "delegates to Addresses::#{key.to_s.classify}::Create.call" do
          klass = "Addresses::#{key.to_s.classify}::Create".constantize
          expect(klass).to receive(:call).with("code")
          described_class.(key.to_s, "code")
        end
      end
    end

    context "unknown coin" do
      it "raises an error" do
        expect { described_class.("xyz123", "code") }.
          to raise_error(ArgumentError, "unknown handler for xyz123")
      end
    end

  end
end
