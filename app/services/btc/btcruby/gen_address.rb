module Btc
  module Addresses
    module Creation
      module Btcruby
        class GenAddress

          extend LightService::Action
          expects :code, :keychain
          promises :public_address

          executed do |c|

          end

        end
      end
    end
  end
end
