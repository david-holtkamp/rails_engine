Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/items', to: 'items#index'
      get '/items/:id', to: 'items#show'
      post '/items', to: 'items#create'

      get '/merchants', to: 'merchants#index'
      get '/merchants/:id', to: 'merchants#show'
      
      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end
    end
  end
end
