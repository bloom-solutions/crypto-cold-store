require 'rails_helper'

module Addresses
  module Btc
    RSpec.describe EnqueueImportAddressJob do

      it "enqueues #{::Btc::ImportAddressJob}" do
        described_class.execute(public_address: "abc")
        expect(::Btc::ImportAddressJob).to have_enqueued_sidekiq_job("abc")
      end

    end
  end
end
