# app/controllers/students_applications_controller.rb

class StudentsApplicationsController < ApplicationController
    def new
        if current_user.students_application
          redirect_to root_path, notice: 'You have already submitted an application.'
        else
          @application = StudentsApplication.new
        end
    end
  
    def create
      @application = current_user.build_students_application(application_params)
      if @application.save
        redirect_to root_path, notice: 'Application submitted successfully.'
      else
        render :new
      end
    end

    def approve
        @application = StudentsApplication.find(params[:id])
        @application.update(status: 'approved')
        redirect_to school_dashboard_path, notice: 'Application approved successfully.'
    end
    
    def reject
        @application = StudentsApplication.find(params[:id])
        @application.update(status: 'rejected')
        redirect_to school_dashboard_path, notice: 'Application rejected successfully.'
    end
  
    private
  
    def application_params
      params.require(:students_application).permit(:FirstName, :LastName, :phone_number, :category)
    end
end
  