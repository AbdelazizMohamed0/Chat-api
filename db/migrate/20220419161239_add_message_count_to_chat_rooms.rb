# frozen_string_literal: true

class AddMessageCountToChatRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms, :Message_Count, :integer
  end
end
