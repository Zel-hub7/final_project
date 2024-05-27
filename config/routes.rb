Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "home#students", as: :authenticated_root
  end

  root to: "home#index"
  get 'application_status', to: 'home#application_status'

  get 'school_dashboard/pending', to: 'school_dashboard#pending', as: 'pending'
  
  get 'school_dashboard/approved', to: 'school_dashboard#approved', as: 'approved_students'
  post 'school_dashboard/mark', to: 'school_dashboard#mark', as: 'mark_students'
  resources :school_dashboard do
    collection do
      get 'all_enrollees', to: 'school_dashboard#all_enrollees'
    end
  end
  
  resources :students_applications, only: [:new, :create, :edit, :update] do
    get 'show', on: :member
    patch 'approve', on: :member
    patch 'reject', on: :member
  end


  namespace :admin do
    resources :schools, only: [:new, :create, :index, :show] do
      collection do
        get 'list_students_with_session_started'
      end
    end
  end
  
  resources :admin, only: [:index] # Assuming AdminController has an index action
end
