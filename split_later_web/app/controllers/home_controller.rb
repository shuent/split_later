class HomeController < ApplicationController
  class HomeControllerError < StandardError; end
  before_action :authenticate_user!
  def index
    @deals = current_user.deals
  end

  def show
    @deal = current_user.deals.find(params[:id])
    @message = Message.new
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
    Deal.transaction do
      @deal = Deal.new
      @deal.save!
      @deal.users << current_user
      @deal.users << find_partner(params[:partner_email])
    end
    flash[:notice] = "succeed save deal"
    redirect_to home_path(@deal)
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

  def find_partner(email)
    partner = User.find_by(email: email)
    raise HomeControllerError.new("can't find the email") if !partner
    raise HomeControllerError.new("can't be partner with your self") if partner == current_user
    raise HomeControllerError.new("partner already exist") if current_user.partners.include?(partner)
    partner

  end

end