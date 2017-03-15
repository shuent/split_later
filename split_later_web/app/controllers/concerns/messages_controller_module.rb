module Concerns::MessagesControllerModule
  class MessagesControllerError < StandardError; end


  private

  def message_params
    params.require(:message).permit(:price, :entry, :borrow_lend)
  end

  def set_message_params(message)
    message.deal_id = params[:deal_id]
    message.actor_id = current_user.id
  end
end