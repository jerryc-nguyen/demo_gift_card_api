module Api
  module V1
    module Clients
      class BrandsController < BaseController
        def index
          brand_ids = current_client.products.status_active.distinct.pluck(:brand_id)
          brands = ::Clients::Queries::CatalogBrands.new(
            Brand.where(id: brand_ids),
            params
          ).call
          render_success(brands)
        end

        def show
          brand = Brand.find(params[:id])
          product_filter_params = {
            query: params[:query],
            min_price: params[:min_price],
            max_price: params[:max_price],
            brand_ids: [brand.id]
          }

          products = ::Clients::Queries::CatalogProducts.new(
            current_client.products,
            product_filter_params
          ).call

          response = {
            brand: brand,
            products: products
          }
          render_success(response)
        end
      end
    end
  end
end
