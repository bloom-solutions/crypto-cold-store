require 'rails_helper'

module Btc
  module Addresses
    module Creation
      module Electrum
        RSpec.describe CreateNewAddress, vcr: {record: :once} do

          let(:client) { InitElectrumClient.execute.electrum_client }

          it "requests for a new address" do
            public_address = described_class.(electrum_client: client)
            expect(public_address).to be_present
          end

        end
      end
    end
  end
end
