# frozen_string_literal: true

require 'elasticsearch/model'
class Message < ApplicationRecord
  belongs_to :chat_room

  include searchable

  after_create { publish_to_dashboard }
  private

  def publish_to_dashboard
    Publisher.publish('messages', content)
  end
end
