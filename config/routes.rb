
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
    namespace :api do
      namespace :v1 do
        resources :applications
        resources :chat_room, only: [:new, :create, :show, :index]
        resources :messages, only: [:create]
        mount ActionCable.server => '/cable'
      end
    end
  end

