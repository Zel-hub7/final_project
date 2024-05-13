# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    rescue_from CanCan::AccessDenied, with: :access_denied
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
      devise_parameter_sanitizer.permit(:account_update, keys: [:role])
    end

    def after_sign_in_path_for(resource)
        if current_user.role == 'school'
          school_dashboard_index_path
        else
          root_path
        end
    end
  
    def after_sign_up_path_for(resource)
      if resource.role == 'school'
        school_dashboard_index_path
      else
        root_path
      end
    end
  
    def after_update_path_for(resource)
      if resource.role == 'school'
        school_dashboard_path
      else
        root_path
      end
    end
end
  