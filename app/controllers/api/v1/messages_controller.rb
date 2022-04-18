class MessagesController < ApplicationController
    def create
        @message = Message.new(message_params)
        if @message.save
           @chat_room = ChatRoom.find(@message.chat_room_id)
           ChatRoomChannel.broadcast_to(@chat_room, message)
           MessageRelayjob.perform_later(message)
           render json: @message.id
        else
           render json: {errors: @message.errors.full_messages}, status: 422
        end
   end
    private
    def message_params
         params.require(:message).permit(:content, :chat_room_id)
    end
end
