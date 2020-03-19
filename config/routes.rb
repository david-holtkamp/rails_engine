Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/items', to: 'items#index'
      get '/items/:id', to: 'items#show'
      post '/items', to: 'items#create'
    end
  end
end
