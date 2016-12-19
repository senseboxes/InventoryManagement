Rails.application.routes.draw do
  get 'monthaverage/yearavg'

  get 'monthaverage/monthavg'

  get 'monthaverage/dailyavg'

  resources :inventories do
    resources :products do
        end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "home#index"
#  match ':controller(/:action(/:id))', via: [ :get, :post, :patch ]
# get 'inventories/:inventory_id/products/:product_id/avg' => 'products#avg'
  get 'inventories/:inventory_id/products' => 'inventories#show'
  get 'monthaverage/yearavg'
  get 'monthaverage/monthavg'
  get 'monthaverage/dailyavg'
end
