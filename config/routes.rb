Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'items/find', to: 'items#find'
      get 'items/find_all', to: 'items#find_all'

      get 'merchants/find', to: 'merchants#find'
      get 'merchants/find_all', to: 'merchants#find_all'

      resources :merchants, only: [:index, :show]

      resources :items

      get 'merchants/:id/items', to: 'merchant_items#index'

      get 'items/:id/merchant', to: 'item_merchant#show'
    end
  end
end
