Rails.application.routes.draw do
  get 'welcome/index'

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    sessions: 'users/sessions' }
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users, path: 'profiles'
end
