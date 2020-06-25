module Xmr
  module Addresses
    RSpec.describe Create do

      it "calls actions in order" do
        actions = [
          InitMoneroClient,
          Creation::GenAddress,
          Creation::SaveAddress,
        ]

        ctx = LightService::Context.new(
          code: "123",
        )

        actions.each do |action|
          expect(action).to receive(:execute).with(ctx).and_return(ctx)
        end

        described_class.(code: "123")
      end
    end
  end
end
