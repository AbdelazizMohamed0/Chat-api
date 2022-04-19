# frozen_string_literal: true

class AddChatCountToApps < ActiveRecord::Migration[5.0]
  def change
    add_column :apps, :Chat_Count, :integer
  end
end
