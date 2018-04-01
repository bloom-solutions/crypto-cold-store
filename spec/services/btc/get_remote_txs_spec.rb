require 'rails_helper'

module Btc
  RSpec.describe GetRemoteTxs, vcr: {record: :once} do

    let(:bitcoiner_client) { InitBitcoinerClient.execute.bitcoiner_client }

    describe ".execute" do
      let(:remote_txs) { [double] }
      it "sets remote_txs in the context with the remote txs we want updates from" do
        expect(described_class).to receive(:of_interest).with(
          bitcoiner_client: bitcoiner_client,
        ).and_return(remote_txs)

        resulting_ctx = described_class.
          execute(bitcoiner_client: bitcoiner_client)

        expect(resulting_ctx.remote_txs).to eq remote_txs
      end
    end

    describe ".of_interest" do
      context "there are known txs" do
        let!(:tx_1) { create(:tx, confirmations: described_class::MAX_CONFS) }
        let!(:tx_2) do
          create(:tx, {
            confirmations: described_class::MAX_CONFS-1,
            tx_id: expected_txids.first,
          })
        end
        let!(:tx_3) { create(:tx, confirmations: described_class::MAX_CONFS-2) }
        let(:expected_txids) do
          # These are txs of muhtvdmsnbQEPFuEmxcChX58fGvXaaUoVt until
          # a558dfc13034b4ead5c8f4a40ebd264ddeabdb81949beb33e4b2af7391045f3e
          # run at 2018-03-30 15:08 GMT+8 (but the test should survive if there
          # are new txs)
          #
          # NOTE: in each page, top is the oldest, lowest is newest -- this is
          # the order that bitcoind returns txs. This is the order we follow in
          # the array:
          [
            "a558dfc13034b4ead5c8f4a40ebd264ddeabdb81949beb33e4b2af7391045f3e",
            "c1660b62d04cd2e8f3ef02b18901fd555c87a61b5efa5767846cac4c023db200",
            "0a81aea507e33e3aeeb879475a1e0472434531ca6d4535caf539e7c6f8c09e62",
            "95a5f979afb7deb8a490d0b7147d95953ce5635a0f8bd1310335c3a9dadaaa71",
            "876c70944b1f6deaaf657fd101358a836420d4ba841ccd403bebb7be9b7e8e6c",
            "216b4efa94da5c8ea6151acdd9ac6ad2e64e0b0740fbc8e3480c54998c02fe40",
          ].to_set
        end

        it "returns the remote txs until the earliest known tx we care about (below #{described_class::MAX_CONFS} confs)" do
          txs = described_class.of_interest(
            bitcoiner_client: bitcoiner_client,
            count: 3, # less than expected_txids.count so we test the pagination
          )

          txids = txs.map {|tx| tx["txid"]}.to_set | expected_txids
          expect(txids).to eq expected_txids
        end
      end

      context "there are no known txs" do
        let(:known_address) { "muhtvdmsnbQEPFuEmxcChX58fGvXaaUoVt" }
        let(:known_txs) do
          fixture = File.read(FIXTURES_DIR.join("btc-listtransactions.json"))
          result = JSON.parse(fixture)["result"]
          result.select do |tx|
            tx["address"] == known_address
          end
        end

        it "fetches all txs" do
          txs = described_class.
            of_interest(bitcoiner_client: bitcoiner_client).
            select { |tx| tx["address"] == known_address }
          expect(txs.count).to be >= known_txs.count
        end
      end
    end

    describe ".until_txid" do
      # Intended use:
      # - we supply txid of the oldest one of which we want updates
      let(:expected_txids) do
        # These are txs of muhtvdmsnbQEPFuEmxcChX58fGvXaaUoVt until
        # 216b4efa94da5c8ea6151acdd9ac6ad2e64e0b0740fbc8e3480c54998c02fe40
        # run at 2018-03-30 15:08 GMT+8 (but the test should survive if there
        # are new txs)
        #
        # NOTE: in each page, top is the oldest, lowest is newest -- this is
        # the order that bitcoind returns txs. This is the order we follow in
        # the array:
        [
          "8adead845a70eaadd56e4fcff6e58fda3dae06bad280161f3d5a6e8effdf3416",
          "63f2912afdb1a93589816a703ead2e50f5a6e1290697415df3d538fb8cefa79c",
          "472d9974ba690640f47267919b26512114fdba59b1ece5c662bea9eea62c5dc2",
          "48e519c2f3695b99fe985b5574165de69baea4f9559be6e0c96247551d0b42e3",
          "a558dfc13034b4ead5c8f4a40ebd264ddeabdb81949beb33e4b2af7391045f3e",
          "c1660b62d04cd2e8f3ef02b18901fd555c87a61b5efa5767846cac4c023db200",
          "0a81aea507e33e3aeeb879475a1e0472434531ca6d4535caf539e7c6f8c09e62",
          "95a5f979afb7deb8a490d0b7147d95953ce5635a0f8bd1310335c3a9dadaaa71",
          "876c70944b1f6deaaf657fd101358a836420d4ba841ccd403bebb7be9b7e8e6c",
          "216b4efa94da5c8ea6151acdd9ac6ad2e64e0b0740fbc8e3480c54998c02fe40",
        ].to_set
      end

      it "fetches all confirmed txs until (and including) the txid" do
        txs = described_class.until_txid(
          bitcoiner_client: bitcoiner_client,
          txid: expected_txids.first,
          count: 3, # less than expected_txids.count so we test the pagination
        )

        txids = txs.map {|tx| tx["txid"]}.to_set | expected_txids
        expect(txids).to eq expected_txids
      end
    end

  end
end
