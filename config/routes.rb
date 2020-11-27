Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users

  get '/index', to: 'index#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get '/upload', to: 'uploader#upload'
  post '/upload/done', to: 'uploader#do_upload', as: 'loader'

  get '/log', to: 'log#profile'
  post '/log/parse', to: 'log#parse'
  post '/log/show', to: 'log#show'
end
