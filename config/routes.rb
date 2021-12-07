Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]

      resources :items

      get 'merchants/:id/items', to: 'merchants#items'

      get 'items/:id/merchant', to: 'items#merchant'
    end
  end
end
