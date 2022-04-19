module Api
  module V1
class ChatRoomsController < ApplicationController
     include Render
     before_action :set_application
     def index
        @chat_rooms = @application.ChatRoom.all
        @render json: @chat_rooms
   end
   def create
        @chat_room = @application.ChatRoom.new(chat_room_params)
        if @chat_room.save
          
             render json: @chat_room.id, status: :created
        else
             render json: {errors: game.errors.full_messages}, status: 422
        end
   end
   def show
        @chat_room = @application.ChatRoom.find(params[:id])
        render json: @chat_room, include: [:messages]
   end
   def destroy
     @chat_room  =@application.ChatRoom.find(params[:id]).destroy
     if @chat_room.save
          render json: @chat_room.id ,head :no_content
     else
          render json: {errors: game.errors.full_messages}, status: 422
     end
    end
   private
   def set_application
     @application = App.find_by!(app_no: params[:app_app_no])
   end
   def chat_room_params
        params.require(:chat_room).permit(:name)
   end
end
end
end