Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :notes
  get '/note/new', to: 'notes#new'
  get '/note/:id/download', to: 'notes#download',  as: 'download_note_path'
  root to: "books#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
