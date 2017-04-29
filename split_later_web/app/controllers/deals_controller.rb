class DealsController < ApplicationController
  include Concerns::DealsControllerModule

  before_action :authenticate_user!
  def index
    @deals = current_user.deals
  end


  def show
    @deal = Deal.find(params[:id])
    @message = Message.new
  rescue => e
    error_message(e)
  end

  def update
    @message = Message.new(message_params)
    set_message_params(@message)
    @message.save
    if @message.save
      redirect_to action: :show
    else
      flash[:error] = "can't add entries"
      redirect_to action: :show
    end
  end

  def new
  end

  def create
    @deal = Deal.new
    create_deal!(@deal)
    flash[:notice] = "succeed saving deal"
    redirect_to deal_path(@deal)
  rescue => e
    flash[:error] = e.message
    render action: :new
  end

  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy
    redirect_to action: :index
  end

  private

  def message_params
    params.require(:message).permit(:price, :entry, :borrow_lend)
  end

  def set_message_params(message)
    message.deal_id = params[:id]
    message.actor_id = current_user.id
  end

end


