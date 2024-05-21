class SchoolDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_school_dashboard


  def index
    @school_name = current_user.school_admins.first.school.name
    @student_applications = StudentsApplication.where(school_id: current_user.school_admins.first.school_id)
  end

  def show
    @school_name = current_user.school_admins.first.school.name
    @student_applications = StudentsApplication.where(school_id: current_user.school_admins.first.school_id)
  end
  
    
    
  private

  def authorize_school_dashboard
    authorize! :manage, :school_dashboard
  rescue CanCan::AccessDenied
    flash[:notice] = "You are not allowed to access this page."
    redirect_to root_path
  end
end
