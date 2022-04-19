# frozen_string_literal: true

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :applications, param: :app_no, only: %i[index show create update] do
        resources :chat_room, param: :id, only: %i[new create show index] do
          resources :messages, param: :id, only: %i[create] do
            collection do
              get :search
              mount ActionCable.server => '/cable'
            end
          end
        end
      end
    end
  end
end
