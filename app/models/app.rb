class App < ApplicationRecord
  has_secure_token :app_no
  has_many :chat_rooms
  validates_uniqueness_of :app_no
  validates :app_name , presence: true 
  self.primary_key = "app_no"
end
