module Api
  module V1
    module Admin
      class ClientProductsController < BaseController
        before_action :set_client

        def bulk_assign
          products = Product.where(id: params[:product_ids])
          products.each do |product|
            @client.client_products.find_or_create_by(product: product)
          end
          render_success(@client.products, status: :created)
        end

        def bulk_remove
          @client.client_products.where(product_id: params[:product_ids]).destroy_all
          render_success({ message: "Products removed from client successfully" })
        end

        private

        def set_client
          @client = Client.find(params[:client_id])
        end
      end
    end
  end
end
