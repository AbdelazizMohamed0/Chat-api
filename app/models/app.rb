# frozen_string_literal: true

class App < ApplicationRecord
  has_secure_token :app_no
  has_many :chat_rooms, dependent: :destroy
  validates :app_no, uniqueness: true
  validates :app_name, presence: true
  self.primary_key = 'app_no'
end
