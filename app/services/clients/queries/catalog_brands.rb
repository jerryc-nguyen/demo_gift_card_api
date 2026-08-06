module Clients
  module Queries
    class CatalogBrands < Base
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
        filter_status
      end


      def filter_status
        return if params[:status].blank?

        @scope = @scope.where(status: params[:status])
      end
    end
  end
end
