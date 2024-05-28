# app/controllers/students_controller.rb
class StudentsController < ApplicationController
    before_action :authenticate_user!
  
    def session_status
      @student = Student.find_by(user_id: current_user.id)
      if @student
        @session = @student.session 
      else
        redirect_to root_path, alert: "Student not found"
      end
    end
  
    def exam_status
      @student = Student.find_by(user_id: current_user.id)
      if @student
        @test = Test.find_by(student_id: @student.id)
      else
        redirect_to root_path, alert: "Student not found"
      end
    end
  
    def reexam_form
      @student = Student.find_by(user_id: current_user.id)
      if @student
        @reexam = Reexam.new # Assuming you have a Reexam model
      else
        redirect_to root_path, alert: "Student not found"
      end
    end
  
    def submit_reexam
      @student = Student.find_by(user_id: current_user.id)
      if @student
        @reexam = Reexam.new(reexam_params)
        @reexam.student = @student
        if @reexam.save
          redirect_to student_path(@student), notice: 'Reexam request submitted successfully.'
        else
          render :reexam_form
        end
      else
        redirect_to root_path, alert: "Student not found"
      end
    end
  
    private
  
    def reexam_params
      params.require(:reexam).permit(:full_name)
    end
end
  