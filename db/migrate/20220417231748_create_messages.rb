# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :chat_room, foreign_key: true

      t.timestamps
    end
  end
end
