module Api
  module V1
    module Clients
      class GiftCardsController < BaseController

        MAX_RETRIES = 5

        def create
          retries = 0
          product = current_client.products.status_active.find(card_params[:product_id])

          begin
            @card = current_client.gift_cards.new(
              product: product,
              pin: card_params[:pin],
              purchase_details: card_params[:purchase_details],
              activation_number: rand(100000..999999),
              amount: product.price
            )
            @card.save!
            log_activity("create_gift_card", "success", payload: card_params.to_hash) rescue nil
            render_success(card_response(@card))
          rescue ActiveRecord::RecordNotUnique => e
            retries += 1
            retry if retries <= MAX_RETRIES
            error_message = "Failed to generate unique activation_number after #{MAX_RETRIES} times."
            log_activity("create_gift_card", "failed", payload: {error: error_message}.merge(card_params.to_hash)) rescue nil 
            return render_error(
              500,
              "RecordNotUnique",
              error_message
            )
          rescue ActiveRecord::RecordInvalid => e
            error_message = @card.errors.full_messages
            log_activity("create_gift_card", "failed", payload: {error: error_message}.merge(card_params.to_hash)) rescue nil
            render_error(422, 'validation_failed', "Validation failed", error_message)
          end
        end

        def destroy
          card = current_client.gift_cards.with_deleted.find_by!(activation_number: params[:id])
          card.update(status: :cancelled)
          card.destroy
          log_activity("cancel_gift_card", "success", payload: { card_id: card.id})
          render_success({ message: "Gift card cancelled successfully" })
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
            amount: card.amount,
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
