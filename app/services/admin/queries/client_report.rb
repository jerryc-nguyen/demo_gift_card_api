module Admin
  module Queries
    class ClientReport

      def call
        relation
      end

      private

      def relation
        Client.left_joins(:gift_cards)
                .select(select_sql)
                .group("clients.id", "clients.name")
                .order("clients.name ASC")
      end

      def select_sql
        <<-SQL
          clients.id,
          clients.name,
          COUNT(
            CASE 
            WHEN gift_cards.status = 0 THEN 1 
            END
          ) AS products_sold,
          SUM(
            CASE 
            WHEN gift_cards.status = 0 THEN gift_cards.amount 
            ELSE 0 
            END
          ) AS total_amount              
        SQL
      end
    end
  end
end
