module Api
  module V1
    module Clients
      class BrandsController < BaseController
        def index
          brand_ids = current_client.products.status_active.distinct.pluck(:brand_id)
          brands = Brand.status_active.where(id: brand_ids)
          brands = brands.search(params[:query]) if params[:query].present?
          render_success(brands)
        end
      end
    end
  end
end
