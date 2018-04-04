module Api
  module V1
    class DepositDetailsController < BaseController

      def show
        result = run DepositDetails::Operations::Api::V1::Show
        render json: DepositDetailRepresenter.new(result["model"]).to_json
      end

    end
  end
end
