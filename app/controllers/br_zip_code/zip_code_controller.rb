require_dependency "new_relic_ping/application_controller"

module BrZipCode
  class ZipCodeController < ApplicationController
    def show
      zip_code = params[:zip_code] || params[:id]

      zip_info = BrZipCode.get_address zip_code

      if zip_info[:error].present?
        respond_to do |format|
          format.json do
            render json: { success: false, message: zip_info[:error] }
          end
        end
      else
        respond_to do |format|
          format.json do
            render json: { success: true, zip_info: zip_info }
          end
        end
      end
    end
  end
end
