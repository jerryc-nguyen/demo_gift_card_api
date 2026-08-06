module Api
  module V1
    module Clients
      class ProductsController < BaseController
        def index
          products = ::Clients::Queries::CatalogProducts.new(
            current_client.products,
            params
          ).call

          products = products.page(page).per(per_page)

          render_success({
            records: products,
            meta: PaginationMeta.from(products)
          })
        end
      end
    end
  end
end
