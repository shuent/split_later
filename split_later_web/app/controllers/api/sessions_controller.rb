module Api
  class SessionsController < Api::ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    # POST /v1/login
    def create
      @user = User.find_for_database_authentication(email: params[:email])
      return invalid_email unless @user

      if @user.valid_password?(params[:password])
        sign_in :user, @user
        update_user_session_info!
        render json: @user, serializer: SessionSerializer, root: nil
      else
        invalid_password
      end
    end

    private

    def invalid_email
      warden.custom_failure!
      render json: { error: 'invalid_email' }
    end

    def invalid_password
      warden.custom_failure!
      render json: { error: 'invalid_password' }
    end

    def update_user_session_info!
      @user.update_access_token! if token_expired?(@user)
      @user.update_tracked_fields!(request)
    end
  end
end
