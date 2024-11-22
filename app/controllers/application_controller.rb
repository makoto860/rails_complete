class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:user_avatar, :user_profile, :user_name])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:user_name])
    end

  private
    def after_sign_in_path_for(resource)
      users_profile_path
    end

    def after_sign_up_path_for(resource)
      users_profile_path
    end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
