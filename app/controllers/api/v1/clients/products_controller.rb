module Api
  module V1
    module Clients
      class ProductsController < BaseController
        def index
          products = current_client.products.status_active
          products = products.search(params[:query]) if params[:query].present?
          render_success(products)
        end
      end
    end
  end
end
