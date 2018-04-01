require 'rails_helper'

module Btc
  module Addresses
    RSpec.describe EnqueueImportAddressJob do

      it "enqueues #{::Btc::ImportAddressJob}" do
        described_class.execute(public_address: "abc")
        expect(::Btc::ImportAddressJob).to have_enqueued_sidekiq_job("abc")
      end

    end
  end
end
