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

  resources :zones
end
