module Clients
  module Queries
    class SpendingGiftCards < Base
      def call
        relations
      end

      private

      def relations
        client.gift_cards.
          includes(:product).
          where(status: :active).
          order(created_at: :desc)
      end
    end
  end
end
