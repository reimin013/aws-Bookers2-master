Rails.application.routes.draw do

  # セッションがない時
  root 'homes#new'
  get 'home/about' => 'homes#about'
  # root 'users#show'これはいらない
  # '/' 'home/about' のページは、1.ルートパスを記述してつくる, 2.homeコントローラを新たに作る
  devise_for :users
  resources :books
  resources :users, only: [:show, :index, :edit, :update]
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
