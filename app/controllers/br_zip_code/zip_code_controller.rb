module BrZipCode
  class ZipCodeController < ApplicationController::Base
    def show
      begin
        response = BrZipCode.get(params[:zip_code] || params[:id])

        if response.nil?
          render json: { success: false, error: 'not-found', message: I18n.t('br_zip_code.not_found')  }
        else
          render json: { success: true, zip_code_info: response }
        end
      rescue Net::OpenTimeout
        render json: { success: false, error: 'not-found', message: I18n.t('br_zip_code.timeout')  }
      end

    end

  end
end
