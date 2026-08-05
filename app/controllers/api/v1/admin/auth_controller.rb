module Api
  module V1
    module Admin
      class AuthController < ApplicationController

        def login
          user = User.find_by(email: params[:email])
          if user&.authenticate(params[:password])
            token = JwtService.encode({
              user_id: user.id
            })
            render_success({ token: token })
          else
            render_error(401, 'unauthorized', "Invalid email or password")
          end
        end

      end
    end
  end
end
