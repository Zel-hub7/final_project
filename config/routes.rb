Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "home#students", as: :authenticated_root
  end

  root to: "home#index"

  get 'school_dashboard/pending', to: 'school_dashboard#pending', as: 'pending'

  resources :school_dashboard do
    collection do
      get 'all_enrollees', to: 'school_dashboard#all_enrollees'
    end
  end
  
  resources :students_applications, only: [:new, :create] do
    get 'show', on: :member
    patch 'approve', on: :member
    patch 'reject', on: :member
  end
  
  resources :admin
end
