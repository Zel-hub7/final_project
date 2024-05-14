class SchoolDashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_school_dashboard
  
    def index
      # Your code here
    end
  
    private
  
    def authorize_school_dashboard
      authorize! :manage, :school_dashboard
    rescue CanCan::AccessDenied
      flash[:notice] = "You are not allowed to access this page."
      redirect_to root_path
    end
end
  