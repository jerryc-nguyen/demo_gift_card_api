module Api
  module V1
    module Clients
      class ProductsController < BaseController
        def index
          products = Clients::Queries::CatalogProducts.new(
            current_client.products,
            params
          ).call

          render_success(products)
        end
      end
    end
  end
end
