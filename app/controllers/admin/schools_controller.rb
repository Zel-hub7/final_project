class Admin::SchoolsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @schools = School.all
  end

  def new
    @school = School.new
  end

  def show
    @school = School.find(params[:id])
    @students = @school.students
    @students_with_reexams = @school.students.joins(:reexams).distinct
  end

  def approve_reexam
    @reexam = Reexam.find(params[:id])
    ActiveRecord::Base.transaction do
      @reexam.update!(status: 'approved')
      @reexam.student.update!(session: 'exam_ready')
    end
    redirect_back fallback_location: admin_school_path(@reexam.student.school), notice: 'Reexam approved successfully.'
  rescue ActiveRecord::RecordInvalid => e
    redirect_back fallback_location: admin_school_path(@reexam.student.school), alert: "Failed to approve reexam: #{e.message}"
  end

  def reject_reexam
    @reexam = Reexam.find(params[:id])
    @reexam.update(status: 'rejected')
    redirect_back fallback_location: admin_school_path(@reexam.student.school), notice: 'Reexam rejected successfully.'
  end

  def create
    @school = School.new(school_params)

    # Create a transaction to ensure atomicity
    ActiveRecord::Base.transaction do
      if @school.save
        # Create a new user with the role of "school admin"
        @admin_user = User.create!(email: params[:school][:admin_email], password: params[:school][:admin_password], role: 'school')

        # Associate the new user with the created school as an admin
        @school_admin = @school.school_admins.create!(user: @admin_user)

        redirect_to admin_schools_path, notice: 'School and school admin were successfully created.'
      else
        render :new
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Failed to create school and school admin: #{e.message}"
    render :new
  end

  def list_students_with_session_started
    @students_with_session_started = Student.where(session: 'started')
  end

  def renewal_applications
    @renewal_applications = RenewalRequest.includes(:student)
  end

  def approve_renewal
    @renewal_request = RenewalRequest.find(params[:id])
    if @renewal_request.update(status: 'approved')
      flash[:notice] = 'Renewal request approved successfully.'
    else
      flash[:alert] = 'Failed to approve renewal request.'
    end
    redirect_to admin_renewal_applications_path
  end

  def reject_renewal
    @renewal_request = RenewalRequest.find(params[:id])
    if @renewal_request.update(status: 'rejected')
      flash[:notice] = 'Renewal request rejected successfully.'
    else
      flash[:alert] = 'Failed to reject renewal request.'
    end
    redirect_to admin_renewal_applications_path
  end


  private

  def authorize_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.role == 'admin'
  end

  def school_params
    params.require(:school).permit(:name, :address)
  end

  def generate_email
    # Generate a random email address for the new user
    SecureRandom.hex(4) + '@example.com'
  end
end
