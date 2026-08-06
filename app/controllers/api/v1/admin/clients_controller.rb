module Api
  module V1
    module Admin
      class ClientsController < BaseController
        before_action :set_client, only: [:update, :destroy]

        def create
          @client = Client.new(client_params)
          
          begin
            @client.api_key = SecureRandom.hex(32)
            @client.save!
            render_success(@client)
          rescue ActiveRecord::RecordNotUnique => e
            retry
          rescue ActiveRecord::RecordInvalid => e
            render_error(403, 'RecordInvalid', @client.errors.full_messages, status: :unprocessable_entity)
          end
        end

        def update
          if @client.update(client_params)
            render_success(@client)
          else
            render_error(403, 'RecordInvalid', @client.errors.full_messages, status: :unprocessable_entity)
          end
        end

        def destroy
          if @client.destroy
            render_success({ message: "Client deleted successfully" })
          else
            render_error(403, 'RecordInvalid', @client.errors.full_messages, status: :unprocessable_entity)
          end
        end

        private

        def set_client
          @client = Client.find(params[:id])
        end

        def client_params
          params.permit(:name, :payout_rate)
        end
      end
    end
  end
end
