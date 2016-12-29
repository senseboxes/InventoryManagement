Rails.application.routes.draw do
  get 'monthaverage/yearavg'

  get 'monthaverage/monthavg'

  get 'monthaverage/dailyavg'
  
  get 'iteminfo/iteminfo_write'
  post 'iteminfo/write_complete'
  get 'iteminfo/setting_page' => 'iteminfo#setting_page'

  resources :inventories do
    resources :products do
        end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "home#index"
#  match ':controller(/:action(/:id))', via: [ :get, :post, :patch ]
# get 'inventories/:inventory_id/products/:product_id/avg' => 'products#avg'
  get 'inventories/:inventory_id/products' => 'inventories#show'
  get "monthaverage/:category" => 'monthaverage#years_category'
  

  
  
end
