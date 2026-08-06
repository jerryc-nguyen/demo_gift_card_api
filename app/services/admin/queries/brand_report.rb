module Admin
  module Queries
    class BrandReport

      def call
        relations
      end

      private

      def relations
        Brand.left_joins(products: :gift_cards)
                             .select(select_sql)
                             .group("brands.id, brands.name")
                             .order("brands.name ASC")
      end

      def select_sql
        <<-SQL
          brands.id,
          brands.name,
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
          ) AS total_sold_amount              
        SQL
      end

    end
  end
end
