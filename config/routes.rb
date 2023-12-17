Rails.application.routes.draw do
  resources :events do
    collection do
      get :search, to: 'events#search'
    end
  end
  
  resources :events
  resources :venues
  resources :bands


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
