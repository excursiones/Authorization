Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get  '/sign_in', to: 'authentication#sign_in';
  get  '/sign_up', to: 'authentication#sign_up';
end
