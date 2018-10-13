Rails.application.routes.draw do
  root 'index#index'
  
  mount ::ApiBase, at: '/api'
  mount GrapeSwaggerRails::Engine => '/api/swagger'
  
  resources :application
  resources :index
  resources :devices
  resources :wx_accounts do
    member do
      get :messages
    end
  end
  
  
end
