class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_attributes
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include Authorize
  include Breadcrumbs
  include Pagy::Backend

  def set_current_attributes
    if user_signed_in?
      Current.user = current_user
      Current.organization = current_user.organizations.first
    else
      Current.user = nil
      Current.organization = nil
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
