Rails.application.routes.draw do
  resources :product_imports
  resources :products do
    collection do
      post :import
    end
  end
  resources :inventories do
    resources :products do
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "home#index"
#  match ':controller(/:action(/:id))', via: [ :get, :post, :patch ]
# get 'inventories/:inventory_id/products/:product_id/avg' => 'products#avg'

# inventory 밑으로 product를 연결하는 경로
  get 'inventories/:inventory_id/products' => 'inventories#show'

# monthaverage의 경로
  get 'monthaverage/yearavg'
  get 'monthaverage/monthavg'
  get 'monthaverage/dailyavg'
  get "monthaverage/:y_index" => 'monthaverage#years_category'

# 설정 페이지의 경로
  get '/setting_page' => 'inventories#setting_page'

# inventory를 카테고리별로 볼 수 있게 만든 경로
  get "index_category/:category_id" => 'inventories#index_category'

# 카테고리를 등록하는 경로
  get "/category_write" => 'inventories#category_write'
  post '/category_write_complete' => 'inventories#category_write_complete'
  get '/categories' => 'inventories#categories'

# Export & Import
  get 'product_imports/complete' => 'product_imports#complete'

end
