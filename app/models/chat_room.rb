# frozen_string_literal: true

class ChatRoom < ApplicationRecord
  belongs_to :app, counter_cache: :chat_count
  has_many :messages, dependent: :destroy
  validates :id, uniqueness: { scope: :app_id }
end
