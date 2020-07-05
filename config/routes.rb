Rails.application.routes.draw do
  root 'users#index'
  resources :users do
    collection do
      get 'sign_in'
      post 'sign_in', action: 'user_session'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
