Rails.application.routes.draw do
  resources :posts
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: :show

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'welcome/index'

  get 'welcome/about'

  root 'welcome#index'

end
