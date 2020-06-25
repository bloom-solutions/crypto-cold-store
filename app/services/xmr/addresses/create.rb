module Xmr
  module Addresses
    class Create

      extend LightService::Organizer

      def self.call(code:)
        ctx = {
          code: code
        }

        with(ctx).reduce(actions)
      end

      def self.actions
        actions = [
          InitMoneroClient,
          Creation::GenAddress,
          Creation::SaveAddress,
        ]
      end

    end
  end
end
