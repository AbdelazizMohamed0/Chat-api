# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApplicationController
      before_action :set_application
      before_action :set_chat

      def create
        @message = Message.new(message_params)
        if @message.save
          @chat_room = ChatRoom.find(@message.chat_room_id)
          ChatRoomChannel.broadcast_to(@chat_room, message)
          MessageRelayjob.perform_later(message) # background job
          render json: @message.id
        else
          render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def search
        render json: Message.search(params[:keyword], @chat.id)
      end

      private

      def message_params
        params.require(:message).permit(:content, :chat_room_id)
      end

      def set_application
        @application = App.find_by!(app_no: params[:app_app_no])
      end

      def set_chat
        @chat = @application.ChatRoom.find_by!(id: params[:chat_room_id])
      end
    end
  end
end
