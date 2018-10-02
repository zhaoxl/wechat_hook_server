Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  mount ::ApiBase, at: '/api'
  mount GrapeSwaggerRails::Engine => '/api/swagger'
  
  resources :application
end
