class SchoolDashboardController < ApplicationController
    before_action :authenticate_user!
   
    def index
        @student_applications = StudentsApplication.all
    end
end
