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
  resources :prod_namelists
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "home#index"

# monthaverage의 경로
  get 'monthaverage/monthavg'
  get 'monthaverage/dailyavg'
  get "monthaverage/:y_index" => 'monthaverage#years_category'

# 설정 페이지의 경로
  get '/setting_page' => 'inventories#setting_page'
  get '/setting_category/:category_id' => 'inventories#setting_category'

# inventory를 카테고리별로 볼 수 있게 만든 경로
  get "index_category/:category_id" => 'inventories#index_category'

# 카테고리를 등록하는 경로
  get "/category_write" => 'inventories#category_write'
  post '/category_write_complete' => 'inventories#category_write_complete'
  get '/categories' => 'inventories#categories'
  post '/categories/:id' => 'inventories#category_destroy'


# 쿠키부여를 위한 경로지정
  post "/home" => 'home#cookie_rec'

end
