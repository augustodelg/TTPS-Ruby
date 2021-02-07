Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :notes
  get '/note/new', to: 'notes#new'
  get '/note/:id/download', to: 'notes#download',  as: 'download_note_path'
  root to: "books#index"
end
