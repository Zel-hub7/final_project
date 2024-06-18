Rails.application.routes.draw do
  get 'renewals/new'
  get 'renewals/create'
  get 'reexams/new'

  devise_for :users

  authenticated :user do
    root to: "home#students", as: :authenticated_root
  end



  root to: "home#index"
  get 'application_status', to: 'home#application_status'
  get 'students/session_status', to: 'students#session_status', as: 'student_session_status'
  post 'admin/issue', to: 'admin#issue', as: 'admin_issue'
  get 'school_dashboard/pending', to: 'school_dashboard#pending', as: 'pending'
  get 'students/exam_status', to: 'students#exam_status', as: 'student_exam_status'
  get 'school_dashboard/approved', to: 'school_dashboard#approved'
  get 'school_dashboard/approve  authenticated :user do
    root to: "home#students", as: :authenticated_root
  endd', to: 'school_dashboard#approved', as: 'approved_students'
  post 'school_dashboard/mark', to: 'school_dashboard#mark', as: 'mark_students'
  get 'students/license_status', to: 'students#license_status', as: 'license_status'

  resources :school_dashboard do
    collection do
      get 'all_enrollees', to: 'school_dashboard#all_enrollees'
      get 'in_session', to: 'school_dashboard#in_session', as: 'in_session'
      post 'mark_exam_ready', to: 'school_dashboard#mark_exam_ready', as: 'mark_exam_ready'
      get 'test_scores'
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
  get 'admin/renewal_applications', to: 'admin/schools#renewal_applications'
  get 'students/reexam', to: 'students#reexam_form', as: 'reexam_form'
  post 'students/submit_reexam', to: 'students#submit_reexam', as: 'submit_reexam'
  get 'schools_dashboard/approved', to: 'school_dashboard#approved', as: 'approved_enrolles' 
  

  resources :students, only: [:show, :edit, :update] do
    member do
      get 'profile'
    end
  end
  
  resources :admin, only: [:index] do
    collection do
      get :issue
      get 'reports', to: 'admin#reports'
    end
  end

  resources :renewals, only: [:new, :create]

end
