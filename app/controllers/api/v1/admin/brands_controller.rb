module Api
  module V1
    module Admin
      class BrandsController < BaseController
        before_action :set_brand, only: [:update_status]

        def create
          brand = Brand.new(brand_params)
          if brand.save
            render_success(brand)
          else
            render_error(:bad_request, "INVALID_BRAND_DATA", "Invalid brand data", brand.errors)
          end
        end

        def update_status
          status = params[:status] == 'active' ? :active : :inactive
          @brand.update!(status: status)
          render_success(@brand)
        end

        private

        def set_brand
          @brand = Brand.find(params[:id])
        end

        def brand_params
          params.permit(:name, :website, :logo_url)
        end
      end
    end
  end
end
