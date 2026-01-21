Rails.application.routes.draw do
  get 'users/new'
  get 'profile_informations/new'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  #
resolve("ProfileInformation") { [:profile_information] }

resources :users, only: [:show] do
  resource :profile_information, only: [:new, :create, :edit, :update]
  resources :meal_plans, only: [:new, :create, :index, :show] do
    resource :chat, only: [:show] do
      resources :messages, only: [:create]
    end
  end
end

resources :meal_plans, only: [:destroy]

end
