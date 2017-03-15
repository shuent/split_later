module Api
  class ApplicationController < ActionController::API

    # http://uraway.hatenablog.com/entry/2016/07/11/090206
    # include AbstractController::Translation

    before_action :authenticate_user_from_token!

    respond_to :json

    ##
    # User Authentication
    # Authenticates the user with OAuth2 Resource Owner Password Credentials
    def authenticate_user_from_token!
      auth_token = request.headers['Authorization']

      if auth_token
        authenticate_with_auth_token auth_token
      else
        authenticate_error
      end
    end

    private

    def authenticate_with_auth_token auth_token
      unless auth_token.include?(':')
        authenticate_error
        return
      end

      user_id = auth_token.split(':').first
      user = User.where(id: user_id).first
      if user && 
        Devise.secure_compare(user.access_token, auth_token) && 
        !token_expired?(user)
        # User can access
        sign_in user, store: false
      else
        authenticate_error
      end
    end

    # expire token in some days.
    def token_expired?(user)
      user.last_sign_in_at < 7.days.ago if user.last_sign_in_at
    end

    ##
    # Authentication Failure
    # Renders a 401 error
    def authenticate_error
      # User's token is either invalid or not in the right format
      render json: { error: 'unauthorized' }, status: 401 # Authentication
    end
  end
end