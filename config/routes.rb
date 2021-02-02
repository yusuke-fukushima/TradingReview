Rails.application.routes.draw do
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
    resources :customers, only: [:show, :edit, :update]
    resources :genres, only: [:index, :show]
    resources :items, only: [:index, :show]
    resources :reviews, only: [:new]
    get 'reviews/confirm' => 'orders#confirm'
    get 'reviews/complete' => 'orders#complete'
  end

  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items
    resources :genres, only: [:index, :create, :edit, :update]
    resources :reviews, only: [:index, :show] do
    end
  end
end