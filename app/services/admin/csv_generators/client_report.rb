module Admin
  module CsvGenerators
    class ClientReport
      def call
        clients_data = ::Admin::Queries::ClientReport.new.call

        CSV.generate(headers: true) do |csv|
          csv << ["Client ID", "Client Name", "Products Sold", "Total Bought Amount"]
          clients_data.each do |client|
            csv << [
              client.id,
              client.name,
              client.products_sold.to_i,
              client.total_amount.to_f.round(2)
            ]
          end
        end

      end
    end
  end
end
