Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  scope :dashboard do
    resources :form do
      post :add_field, on: :collection
      post :remove_field, on: :collection
      get :answer, as: 'dashboard_answer'
      get 'answer/:id', to: 'form#full_answer', as: 'full_answer'
    end
  end

  resources :form_answer, only: [:show, :answer], path: '/' do
    post :answer, on: :member
    get :success, on: :collection
  end

  # Defines the root path route ("/")
  root "form#index"
end
