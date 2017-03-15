module Api
  class MessagesController < ApplicationController
    include Concerns::MessagesControllerModule

    def create
      @message = Message.new(message_params)
      set_message_params(@message)
      @message.save
      if @message.save
        render json: @message
      else
        render json: { message: "coud not create message"}
      end
    end

    def destroy
      if Message.find(:id).destroy
        render json: {message: "deleted message"}
      else
        render json: {messeage: "could not delete message"}}
      end
    end

  end
end