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
    resources :genres, only: [:index] do
      resources :items, only: [:index, :show]
    end
    resources :reviews, only: [:new]
    get 'reviews/confirm' => 'reviews#confirm'
    get 'reviews/complete' => 'reviews#complete'
  end

  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items
    # 建前上ジャンルに削除メソッドを加えている
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :reviews, only: [:index, :show] do
    end
  end
end