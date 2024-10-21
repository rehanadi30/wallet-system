class ApplicationController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods
    
    before_action :authenticate
    
    private
    
    def authenticate
      authenticate_token || render_unauthorized
    end
    
    def authenticate_token
      authenticate_with_http_token do |token, _options|
        begin
          decoded = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
          @current_user = User.find(decoded["user_id"])
        rescue JWT::DecodeError, ActiveRecord::RecordNotFound
          nil
        end
      end
    end
    
    def render_unauthorized
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end