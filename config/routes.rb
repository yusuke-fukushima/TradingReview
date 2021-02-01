Rails.application.routes.draw do
  devise_for :customers
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#new_guest'
  end
  root to: 'homes#top'
end