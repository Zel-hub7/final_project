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

    def reports
      @total_students = Student.count
      @total_licenses = License.count
      @total_schools = School.count
  
      @students_per_school = School.joins(:students).select("schools.*, COUNT(students.id) AS student_count").group("schools.id")
      @students_by_category = Student.group(:category).count
      @licenses_expiring_soon = License.where("expiration_date < ?", 1.month.from_now).count
  
      @average_test_scores = Student.includes(:school, tests: [:student]).map do |student|
        {
          id: student.id,
          FirstName: student.FirstName,
          LastName: student.LastName,
          school_name: student.school.name,
          avg_theory_exam: student.tests.average(:theory_exam).to_f.round(2),
          avg_practical_exam: student.tests.average(:practical_exam).to_f.round(2),
          last_test_status: student.tests.last&.status # Use safe navigation operator (&.) to avoid NilClass error
        }
      end
  
      @test_pass_fail_rates = Test.group(:status).count
      @reexam_requests = Reexam.group(:status).count
      @student_applications_status = StudentsApplication.group(:status).count
    end
  
    private
  
    def authorize_admin
      redirect_to root_path, alert: 'Access denied.' unless current_user.role == 'admin'
    end

    def generate_license_number
      SecureRandom.hex(4) # Generate a random hex string as the license number
    end
    
    def generate_expiration_date
      Date.today + 4.year # Set the expiration date to be 4 year from today
    end
  end
  