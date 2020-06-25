module DepositDetails
  module Operations
    module Api
      module V1
        class Show < ApplicationOperation

          # TODO test each min is an enum in Address#coin
          MIN = {
            btc: 0.00001,
            eth: 0.00001,
            xmr: 0.00001,
          }.with_indifferent_access

          step :init_model!
          step :set_min!
          step :find_or_create_address!

          private

          def init_model!(options, **)
            options["model"] = DepositDetail.new
          end

          def set_min!(options, params:, **)
            options["model"].min = MIN[params[:coin]]
          end

          def find_or_create_address!(options, params:, **)
            result = Addresses::Operations::FindOrCreate.(params: params)
            options["model"].address = result["model"].address
          end

        end
      end
    end
  end
end
