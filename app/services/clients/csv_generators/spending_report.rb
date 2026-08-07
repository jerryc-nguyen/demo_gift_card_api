require 'csv'

module Clients
  module CsvGenerators
    class SpendingReport < Base

      def call
        spending_gift_cards = ::Clients::Queries::SpendingGiftCards.new(client: client, options: options).call
        CSV.generate(headers: true) do |csv|
          csv << ["Activation Number", "Product Id", "Amount", "Date"]
          spending_gift_cards.each do |gift_card|
            csv << [
              gift_card.activation_number,
              gift_card.product_id,
              gift_card.amount,
              gift_card.created_at
            ]
          end
        end
      end
    end
  end
end
