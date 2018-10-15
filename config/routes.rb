Rails.application.routes.draw do
  root 'devices#index'
  
  mount ::ApiBase, at: '/api'
  mount GrapeSwaggerRails::Engine => '/api/swagger'
  
  resources :application
  resources :index
  resources :devices
  resources :wx_accounts do
    resources :friends
  end
  
  
end
