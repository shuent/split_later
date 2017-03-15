module Api
  class DealsController < Api::ApplicationController
    include Concerns::DealsControllerModule

    def index
      # avoid error of serializer
      # current_user.deals では取れない.
      @deals = Deal.joins(:users)
        .where(user_deals:{user_id: current_user.id})
        .references(:users) #current_user.deals
      # binding.pry
      # この fieldsというオプションを探すのにめちゃ時間かかった
      render json: @deals, fields: [:id]
    end

    def show
      @deal = Deal.find(params[:id])
      render json: @deal
    rescue => e
      error_message(e)
    end

    def create
      @deal = Deal.new
      create_deal!(@deal)
      render json: @deal

    rescue => e
      error_message(e)
    end
  end
end
