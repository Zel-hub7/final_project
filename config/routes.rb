Rails.application.routes.draw do
  get 'reexams/new'

  devise_for :users

  authenticated :user do
    root to: "home#students", as: :authenticated_root
  end

  root to: "home#index"
  get 'application_status', to: 'home#application_status'
  get 'students/session_status', to: 'students#session_status', as: 'student_session_status'

  get 'school_dashboard/pending', to: 'school_dashboard#pending', as: 'pending'
  get 'students/exam_status', to: 'students#exam_status', as: 'student_exam_status'
  get 'school_dashboard/approved', to: 'school_dashboard#approved', as: 'approved_students'
  post 'school_dashboard/mark', to: 'school_dashboard#mark', as: 'mark_students'

  resources :school_dashboard do
    collection do
      get 'all_enrollees', to: 'school_dashboard#all_enrollees'
      get 'in_session', to: 'school_dashboard#in_session', as: 'in_session'
      post 'mark_exam_ready', to: 'school_dashboard#mark_exam_ready', as: 'mark_exam_ready'
    end
  end
  
  resources :students_applications, only: [:new, :create, :edit, :update] do
    get 'show', on: :member
    patch 'approve', on: :member
    patch 'reject', on: :member
  end

  namespace :admin do
    resources :schools, only: [:new, :create, :index, :show] do
      member do
        patch 'approve_reexam'
        patch 'reject_reexam'
      end
      collection do
        get 'list_students_with_session_started'
      end
    end

    resources :students, only: [] do
      resources :tests, only: [:create]
    end
  end

  get 'students/reexam', to: 'students#reexam_form', as: 'reexam_form'
  post 'students/submit_reexam', to: 'students#submit_reexam', as: 'submit_reexam'

  resources :students, only: [:show]
  
  resources :admin, only: [:index] # Assuming AdminController has an index action
end
