# frozen_string_literal: true

class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    ActionCable.server.broadcast "chat_room:#{message.chat_room.id}", {
      message: MessageController.render(message)
    }
  end
end
