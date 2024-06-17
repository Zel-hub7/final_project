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


  

  def in_session
    @school_name = current_user.school_admins.first.school.name
    @students = Student.where(school_id: current_user.school_admins.first.school_id)

  end

  def mark_exam_ready
    @students = Student.where(id: params[:student_ids])
    @students.update_all(session: 'exam_ready')
    redirect_to in_session_school_dashboard_index_path, notice: "Selected students have been marked as exam ready."
  end
  
  

  def mark
    student_ids = params[:student_ids]
    if student_ids.present?
      Student.where(id: student_ids).update_all(session: 'started')
      flash[:notice] = "Selected students have been marked as started."
    else
      flash[:alert] = "No students selected."
    end
    redirect_to school_dashboard_index_path
  end


   
    
  private

  def authorize_school_dashboard
    authorize! :manage, :school_dashboard
  rescue CanCan::AccessDenied
    flash[:notice] = "You are not allowed to access this page."
    redirect_to root_path
  end
end
