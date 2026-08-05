module Api
  module V1
    module Clients
      class BaseController < ApplicationController
        before_action :authenticate_client!

        attr_reader :current_client


        private

        def authenticate_client!
          api_key = request.headers["X-Api-Key"]
          @current_client = Client.find_by(api_key: api_key)

          unless @current_client
            return render_error(401, 'unauthorized', "Unauthorized")
          end
        end

      end
    end
  end
end
