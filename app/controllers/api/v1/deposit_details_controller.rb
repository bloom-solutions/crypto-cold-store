require 'rails_helper'

module Api
  module V1
    class DepositDetailsController < BaseController

      def show
        result = run DepositDetails::Operations::Api::V1::Show
        render json: result["representer.render.class"].new(result["model"]).to_json
      end

    end
  end
end
