require 'csv'

module Admin
  module CsvGenerators
    class BrandReport
      def call
        brands_data = ::Admin::Queries::BrandReport.new.()
        CSV.generate(headers: true) do |csv|
          csv << ["Brand ID", "Brand Name", "Products Sold", "Total Sold Amount"]
          brands_data.each do |brand|
            csv << [
              brand.id,
              brand.name,
              brand.products_sold.to_i,
              brand.total_amount.to_f.round(2)
            ]
          end
        end
      end
    end
  end
end
