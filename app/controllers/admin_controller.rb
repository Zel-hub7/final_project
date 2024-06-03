class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin
  
    def index
      # Your existing code for the index action
    end

    def issue
      @students = Student.all
      if request.post? && params[:student_id].present?
        student = Student.find(params[:student_id])
        # Generate a license number (you can implement your own logic here)
        license_number = generate_license_number
        # Set the expiration date (you can implement your own logic here)
        expiration_date = generate_expiration_date
        # Create a license record for the student
        License.create(license_number: license_number, expiration_date: expiration_date, student_id: student.id)
        redirect_to admin_issue_path, notice: "License issued successfully"
      end
    end
  
    private
  
    def authorize_admin
      redirect_to root_path, alert: 'Access denied.' unless current_user.role == 'admin'
    end

    def generate_license_number
      SecureRandom.hex(4) # Generate a random hex string as the license number
    end
    
    def generate_expiration_date
      Date.today + 1.year # Set the expiration date to be 1 year from today
    end
  end
  