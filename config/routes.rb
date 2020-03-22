Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/:id/merchant', to: 'merchants#show'
        get '/find', to: 'finders#show'
        get '/find_all', to: 'finders#index'
      end

      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find', to: 'finders#show'
        get '/find_all', to: 'finders#index'
      end

      get '/merchants', to: 'merchants#index'
      get '/merchants/:id', to: 'merchants#show'

      get '/items', to: 'items#index'
      get '/items/:id', to: 'items#show'
      post '/items', to: 'items#create'
    end
  end
end
