require 'csv'

module Clients
  module CsvGenerators
    class CancelReport < Base

      def call
        cancel_gift_cards = ::Clients::Queries::CancelGiftCards.new(client: client, options: options).call
        CSV.generate(headers: true) do |csv|
          csv << ["Activation Number", "Product Id", "Amount", "Cancel Date"]
          cancel_gift_cards.each do |gift_card|
            csv << [
              gift_card.activation_number,
              gift_card.product_id,
              gift_card.amount,
              gift_card.deleted_at
            ]
          end
        end
      end
      
    end
  end
end
