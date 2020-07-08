Rails.application.routes.draw do
  
  root 'users#index'
  get 'events', to: "events#index"
  get 'events/:id', to: "events#show"
  resources :users do
    member do
      get 'new_event', controller: 'events', action: 'new'
      post 'create_event', controller: 'events', action: 'create'
    end
    collection do
      get 'sign_in'
      post 'sign_in', action: 'user_session'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
