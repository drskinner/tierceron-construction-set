Rails.application.routes.draw do
  get 'welcome/index'

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :socials do
    post :import, on: :collection
  end

  resources :users, path: 'profiles'
  match '/admin_create', to: 'users#admin_create', via: [:post, :get]

  resources :zones
end
