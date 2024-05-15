Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "home#students", as: :authenticated_root
  end

  root to: "home#index"
  
  resources :school_dashboard
  
  resources :students_applications, only: [:new, :create] do
    patch 'approve', on: :member
    patch 'reject', on: :member
  end
  
  resources :admin
end
