Rails.application.routes.draw do
  root 'works#index'


  get '/works', to: 'works#index'

  # get '/works/new', to: 'works#new', as: 'new_work'

  get '/books/new', to: 'books#new', as: 'new_book'
  post '/books', to: 'books#create'

  post '/works', to: 'books#create'

  get '/works/:id', to: 'works#show', as: 'work'

  get '/albums/new', to: 'albums#new', as: 'new_album'
  post '/albums', to: 'albums#create'

  post '/works', to: 'album#create'

  get '/movies/new', to: 'movies#new', as: 'new_movie'
  post '/movies', to: 'movies#create'

  post '/works', to: 'movies#create'

  get '/albums', to: 'albums#index'

  get '/movies', to: 'movies#index'

  get '/books', to: 'books#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
