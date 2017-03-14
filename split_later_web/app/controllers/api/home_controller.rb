module Api
  class HomeController < ApplicationController
    def index
      @deals = current_user.deals
      render json: @deals
    end

    def show
      @deal = Deal.find(params[:id])
      render json: @deal
    end
  end
end
