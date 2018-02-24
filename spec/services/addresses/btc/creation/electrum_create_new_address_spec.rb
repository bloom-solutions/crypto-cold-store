require 'rails_helper'

module Addresses
  module Btc
    module Creation
      RSpec.describe ElectrumCreateNewAddress, vcr: {record: :once} do

        let(:client) { InitElectrumClient.execute.electrum_client }

        it "requests for a new address" do
          public_address = described_class.(electrum_client: client)
          expect(public_address).to be_present
        end

      end
    end
  end
end
