module Api
  module V1
    module Clients
      class ReportsController < BaseController
        def spending
          csv_str = ::Clients::CsvGenerators::SpendingReport.new(client: current_client).call
          render_success({ csv: csv_str })
        end

        def cancel
          csv_str = ::Clients::CsvGenerators::CancelReport.new(client: current_client).call
          render_success({ csv: csv_str })
        end
      end
    end
  end
end
