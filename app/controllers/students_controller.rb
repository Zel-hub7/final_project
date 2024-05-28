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
end
  