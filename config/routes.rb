ImpaqBackend::Application.routes.draw do
  resources :users

  resources :campaigns
  resources :dashboard, only: [:index]
  resources :sessions, only: [:new, :create, :destroy]

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  resources :links
  resources :shares
  resources :click_throughs

  root to: 'static_pages#index'

  get 'about' => 'static_pages#about'
  get 'funding'  => 'static_pages#funding'
  get 'iframe' => 'iframe#index'
  get 'l/:slug' => 'links#follow'
end
