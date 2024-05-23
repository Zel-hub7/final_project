class Admin::SchoolsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @schools = School.all
  end

  def new
    @school = School.new
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
  
  
  private
  
  def generate_email
    # Generate a random email address for the new user
    SecureRandom.hex(4) + '@example.com'
  end
  
  def generate_password
    # Generate a random password for the new user
    SecureRandom.hex(8)
  end
  
  
  
  

  private

  def authorize_admin
    redirect_to root_path, alert: 'Access denied.' unless current_user.role == 'admin'
  end

  def school_params
    params.require(:school).permit(:name, :address)
  end

  def generate_password
    # Generate a random password for the new admin user
    SecureRandom.hex(8)
  end
end