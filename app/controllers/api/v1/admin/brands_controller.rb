module Api
  module V1
    module Admin
      class BrandsController < ApplicationController

        def create
          brand = Brand.new(brand_params)
          if brand.save
            render_success(brand)
          else
            render_error(:bad_request, "INVALID_BRAND_DATA", "Invalid brand data", brand.errors)
          end
        end

        private

        def brand_params
          params.permit(:name, :website, :logo_url)
        end
      end
    end
  end
end
