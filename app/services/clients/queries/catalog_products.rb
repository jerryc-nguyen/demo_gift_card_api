module Clients
  module Queries
    class CatalogProducts < Base
      attr_reader :params

      def initialize(scope = nil, params = {})
        @scope = scope
        @params = params
      end

      def call
        search
        filter

        @scope
      end

      private

      def search
        return if params[:query].blank?

        @scope = @scope.search(params[:query])
      end

      def filter
        filter_price
        filter_brands
      end

      def filter_price
        filter_min_price
        filter_max_price
      end

      def filter_min_price
        return if params[:min_price].blank?

        @scope = @scope.where("products.price >= ?", params[:min_price])
      end

      def filter_max_price
        return if params[:max_price].blank?

        @scope = @scope.where("products.price <= ?", params[:max_price])
      end

      def filter_brands
        return if params[:brand_ids].blank?

        @scope = @scope.where(brand_id: params[:brand_ids])
      end
    end
  end
end
