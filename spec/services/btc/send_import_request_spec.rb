require 'rails_helper'

module Btc
  RSpec.describe SendImportRequest, vcr: {record: :once} do

    let(:bitcoiner_client) { InitBitcoinerClient.execute.bitcoiner_client }

    it "sends the request to import the public address in the default account, without rescanning" do
      expect(bitcoiner_client).to receive(:request).with(
        "importaddress",
        "muhtvdmsnbQEPFuEmxcChX58fGvXaaUoVt",
        "",
        false,
      ).and_call_original

      resulting_ctx = described_class.execute({
        bitcoiner_client: bitcoiner_client,
        public_address: "muhtvdmsnbQEPFuEmxcChX58fGvXaaUoVt",
      })

      # nil means it is successful
      expect(resulting_ctx.import_address_response).to be_nil
    end

  end
end
