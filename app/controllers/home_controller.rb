class HomeController < ApplicationController
    before_action :authenticate_user!, only: [:students]
    def index
    end

    def students 
    end

    def application_status
        @application_status = current_user.students_application&.status
    end
end
