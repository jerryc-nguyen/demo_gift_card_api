module Api
  module V1
    module Admin
      class ProductsController < ApplicationController
        before_action :set_brand
        before_action :set_product, only: [:update, :destroy, :update_status]

        def create
          product = @brand.products.new(product_params)
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

        def update_status
          status = params[:status] == 'active' ? :active : :inactive
          @product.update!(status: status)
          render_success(@product)
        end

        def destroy
          if @product.destroy
            render_success({ message: "Product deleted successfully" })
          else
            render_error(:bad_request, "INVALID_PRODUCT_DATA", "Invalid product data", @product.errors)
          end
        end

        private

        def set_brand
          @brand = Brand.find(params[:brand_id])
        end

        def set_product
          @product = @brand.products.find(params[:id])
        end

        def product_params
          params.permit(:brand_id, :name, :price)
        end
      end
    end
  end
end
