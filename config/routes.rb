Rails.application.routes.draw do
  get 'reviews/index'
  get 'reviews/show'
  get 'items/index'
  get 'items/new'
  get 'items/create'
  get 'items/show'
  get 'items/edit'
  get 'items/update'
  get 'genres/index'
  get 'genres/create'
  get 'genres/edit'
  get 'genres/update'
  get 'customers/index'
  get 'customers/show'
  get 'customers/edit'
  get 'customers/update'
  get 'reviews/new'
  get 'items/index'
  get 'items/show'
  get 'genres/index'
  get 'customers/show'
  get 'customers/edit'
  get 'customers/update'
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  
  devise_scope :admin do
    post 'admins/guest_sign_in', to: 'admins/sessions#new_guest'
  end
  
  devise_for :customers
  
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#new_guest'
  end
  
  root to: 'homes#top'

  namespace :public do
  end

  namespace :admin do
    root to: 'homes#top'
  end
end