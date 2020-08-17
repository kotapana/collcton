Rails.application.routes.draw do
  root to: 'home#index'

  # seacrhのURL
  get 'search' => 'search#show'

  # 商品詳細のURL(/items/1　などになる)
  resources :items, only: :show

  # リストLPのURL(/categories/1　などになる)
  resources :categories, only: [:show,:index]
  
  # リストLPのURL(/brands/1　などになる)
  resources :brands, only: [:show,:index]
end
