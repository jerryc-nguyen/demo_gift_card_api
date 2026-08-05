module Api
  module V1
    module Admin
      class ProductsController < ApplicationController
        before_action :set_product, only: [:update, :destroy]

        def create
          product = Product.new(product_params)
          if product.save
            render_success(product, status: :created)
          else
            render_error(:bad_request, "INVALID_PRODUCT_DATA", "Invalid product data", product.errors)
          end
        end

        def update
          if @product.update(product_params)
            render_success(@product)
          else
            render_error(:bad_request, "INVALID_PRODUCT_DATA", "Invalid product data", @product.errors)
          end
        end

        def destroy
          if @product.destroy
            render_success({ message: "Product deleted successfully" })
          else
            render_error(:bad_request, "INVALID_PRODUCT_DATA", "Invalid product data", @product.errors)
          end
        end

        private

        def set_product
          @product = Product.find(params[:id])
        end

        def product_params
          params.permit(:brand_id, :name, :price)
        end
      end
    end
  end
end
