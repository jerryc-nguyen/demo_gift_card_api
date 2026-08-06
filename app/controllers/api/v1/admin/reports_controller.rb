require "csv"

module Api
  module V1
    module Admin
      class ReportsController < BaseController
        def brands
          csv_str = ::Admin::CsvGenerators::BrandReport.new.call
          render_success({ csv: csv_str })
        end

        def clients
          csv_str = ::Admin::CsvGenerators::ClientReport.new.call
          render_success({ csv: csv_str })
        end
      end
    end
  end
end
