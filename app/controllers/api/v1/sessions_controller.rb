module Api
    module V1
      class SessionsController < ApplicationController
        skip_before_action :authenticate, only: [:create]
        
        def create
          user = User.find_by(email: params[:email])
          if user&.authenticate(params[:password])
            token = JWT.encode(
              { user_id: user.id, exp: 24.hours.from_now.to_i },
              Rails.application.credentials.secret_key_base
            )
            render json: { token: token, user_id: user.id }
          else
            render json: { error: 'Invalid credentials' }, status: :unauthorized
          end
        end
      end
    end
  end