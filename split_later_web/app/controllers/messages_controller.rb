class MessagesController < ApplicationController
  include Concerns::MessagesControllerModule

  def create
    @message = Message.new(message_params)
    set_message_params(@message)
    @message.save
    if @message.save
      redirect_to controller: :deals, action: :show, id: params[:deal_id]
    else
      flash[:error] = "could not create message"
      redirect_to controller: :deals, action: :show, id: params[:deal_id]

    end
  end

  def destroy
    if Message.find(:id).destroy
      redirect_to controller: :deals, action: :show
    else
      flash[:error] = "could not delete message"
      redirect_to controller: :deals, action: :show
    end
  end
end
