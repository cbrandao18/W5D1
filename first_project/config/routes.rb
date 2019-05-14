Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/users', to: 'users#index', as: 'users'
  # post '/users', to: 'users#create'
  # get '/users/new', to: 'users#new', as: 'new_user'
  # get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  # get '/users/:id', to: 'users#show', as: 'user'
  # patch '/users/:id', to: 'users#update'
  # put '/users/:id', to: 'users#update'
  # delete '/users/:id', to: 'users#destroy'

  resources :users, only: [:index, :create, :update, :show, :destroy] do
    resources :artworks, only: [:index]
  end

  resources :artworks, only: [:create, :update, :show, :destroy] do
    member do
      post 'like', to: 'artworks#like', as: 'like' #create a like
      delete 'unlike', to: 'artworks#unlike', as: 'unlike' #destroy a like
    end
  end
  resources :comments, only: [:create, :destroy, :index] do
    member do
      post 'like', to: 'comments#like', as: 'like' #create a like
      delete 'unlike', to: 'comments#unlike', as: 'unlike' #destroy a like
    end
  end

  resources :artwork_shares, only: [:create, :destroy]

end
