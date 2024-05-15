class HomeController < ApplicationController
    before_action :authenticate_user!, only: [:students]
    def index
    end

    def students 
    end
end
