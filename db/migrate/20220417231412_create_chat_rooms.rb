# frozen_string_literal: true

class CreateChatRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_rooms do |t|
      t.string :name
      t.references :app, foreign_key: true

      t.timestamps
    end
  end
end
