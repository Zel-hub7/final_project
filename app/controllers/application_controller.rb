class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied, with: :access_denied

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

  def after_sign_in_path_for(resource)
    case current_user.role
    when 'school'
      school_dashboard_index_path
    when 'admin'
      admin_index_path
    else
      root_path
    end
  end

  def after_sign_up_path_for(resource)
    case resource.role
    when 'school'
      school_dashboard_index_path
    when 'admin'
      admin_index_path
    else
      root_path
    end
  end

  def after_update_path_for(resource)
    case resource.role
    when 'school'
      school_dashboard_path
    when 'admin'
      admin_path
    else
      root_path
    end
  end

  def current_student
    @current_student ||= Student.find_by(user_id: current_user.id)
  end
  helper_method :current_student
end
