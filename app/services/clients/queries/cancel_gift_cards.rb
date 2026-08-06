module Clients
  module Queries
    class CancelGiftCards < Base
      
      def call
        relations
      end

      private

      def relations
        client.gift_cards.
                with_deleted.
                cancelled.
                includes(:product).
                order(created_at: :desc)
      end

    end
  end
end
