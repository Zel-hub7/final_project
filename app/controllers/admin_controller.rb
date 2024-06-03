class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin
  
    def index
      # Your existing code for the index action
    end

    def issue
      @students = Student.all
    end
  
    private
  
    def authorize_admin
      redirect_to root_path, alert: 'Access denied.' unless current_user.role == 'admin'
    end
  end
  