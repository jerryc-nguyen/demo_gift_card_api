module Api
  module V1
    module Admin
      class AuthController < ApplicationController

        def register
          user = User.new(register_params)
          if user.save
            token = JwtService.encode({ user_id: user.id })
            log_activity("register", "success", payload: { email: user.email, user_id: user.id })
            render_success({ token: token, user: { id: user.id, email: user.email, full_name: user.full_name } }, status: :created)
          else
            log_activity("register", "failed", payload: { email: params[:email] })
            render_error(400, 'bad_request', "Validation failed", user.errors.full_messages)
          end
        end

        def login
          user = User.find_by(email: params[:email])
          if user&.authenticate(params[:password])
            token = JwtService.encode({
              user_id: user.id
            })
            log_activity("login", "success", payload: { email: user.email, user_id: user.id })
            render_success({ token: token })
          else
            log_activity("login", "failed", payload: { email: params[:email] })
            render_error(401, 'unauthorized', "Invalid email or password")
          end
        end

        private

        def register_params
          params.permit(:email, :password, :full_name)
        end

      end
    end
  end
end
