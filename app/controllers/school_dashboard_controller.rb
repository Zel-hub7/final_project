class SchoolDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_school_dashboard


  def index
    @school_name = current_user.school_admins.first.school.name
    @student_applications = StudentsApplication.where(school_id: current_user.school_admins.first.school_id)
  end

  def pending
    @school_name = current_user.school_admins.first.school.name
    @student_applications = StudentsApplication.where(school_id: current_user.school_admins.first.school_id)
  end

  def show
    @application = StudentsApplication.find(params[:id])
  end

  def all_enrollees
    @school_name = current_user.school_admins.first.school.name
    @all_enrollees = StudentsApplication.where(school_id: current_user.school_admins.first.school_id)
  end

  def approved
    @school_name = current_user.school_admins.first.school.name
    @approved_students = Student.where(school_id: current_user.school_admins.first.school_id)
  end
  
  

  def mark
    student_ids = params[:student_ids]
    if student_ids.present?
      Student.where(id: student_ids).update_all(session: 'started')
      flash[:notice] = "Selected students have been marked as started."
    else
      flash[:alert] = "No students selected."
    end
    redirect_to approved_students_path
  end


  
    
    
  private

  def authorize_school_dashboard
    authorize! :manage, :school_dashboard
  rescue CanCan::AccessDenied
    flash[:notice] = "You are not allowed to access this page."
    redirect_to root_path
  end
end
