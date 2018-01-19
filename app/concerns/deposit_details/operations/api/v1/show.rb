module DepositDetails
  module Operations
    module Api
      module V1
        class Show < ApplicationOperation

          extend Representer::DSL

          # TODO test each min is an enum in Address#coin
          MIN = {
            btc: 0.001,
          }.with_indifferent_access

          representer :render do
            include Representable::JSON
            property :address
            property :min
          end

          step :init_model!
          # step Contract::Build()
          # step Contract::Validate()
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
