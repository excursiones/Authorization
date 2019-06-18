Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post  '/sign_in', to: 'authentication#sign_in';
  post  '/sign_up', to: 'authentication#sign_up';
end
