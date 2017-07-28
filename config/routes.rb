Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :wikis

  devise_for :users, controllers: { registrations: 'users/registrations'}

  devise_scope :user do
    patch 'user' => 'users/registrations#downgrade_user', as: :users_registration
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
