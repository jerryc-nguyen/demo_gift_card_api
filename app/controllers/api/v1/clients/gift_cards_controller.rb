module Api
  module V1
    module Clients
      class GiftCardsController < BaseController
        def create
          product = current_client.products.status_active.find(card_params[:product_id])
          begin
            @card = GiftCard.new(
              product: product,
              client: current_client,
              pin: card_params[:pin],
              purchase_details: card_params[:purchase_details],
              activation_number: rand(100000..999999)
            )
            @card.save!
            render_success(card_response(@card))
          rescue ActiveRecord::RecordNotUnique => e
            retry
          rescue ActiveRecord::RecordInvalid => e
            render_error(403, 'RecordInvalid', @card.errors.full_messages, status: :unprocessable_entity)
          end
        end

        def cancel
          card = current_client.cards.find_by!(activation_number: params[:activation_number])
          card.update!(status: :cancelled)
          render_success(card_response(card))
        end

        private

        def card_params
          params.permit(:product_id, :pin, :purchase_details)
        end

        def card_response(card)
          {
            activation_number: card.activation_number,
            pin: card.pin,
            purchase_details: card.purchase_details,
            status: card.status,
            product: {
              id: card.product.id,
              name: card.product.name,
              price: card.product.price,
              brand: {
                id: card.product.brand.id,
                name: card.product.brand.name
              }
            }
          }
        end
      end
    end
  end
end
