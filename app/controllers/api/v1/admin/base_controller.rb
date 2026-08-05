module Api
  module V1
    module Admin
      class BaseController < ApplicationController
        before_action :authenticate_admin!
        attr_reader :current_user

        private

        def authenticate_admin!
          token = request.headers["Authorization"]&.split(" ")&.last
          decoded = JwtService.decode(token)

          if decoded
            @current_user = User.find(decoded[:user_id])
          else
            return render_error(401, 'unauthorized', "Unauthorized")
          end
        end

      end
    end
  end
end
