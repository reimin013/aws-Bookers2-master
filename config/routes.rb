Rails.application.routes.draw do

  # セッションがない時
  root 'homes#new'
  get 'home/about' => 'homes#about'
  # root 'users#show'これはいらない
  # '/' 'home/about' のページは、1.ルートパスを記述してつくる, 2.homeコントローラを新たに作る
  devise_for :users

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
