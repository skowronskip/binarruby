class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :username, :email, :password,
                                                               :password_confirmation, :remember_me, :picture, :picture_cache, :remove_picture, :avatar) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :username, :email, :password,
                                                                      :password_confirmation, :current_password, :picture, :picture_cache, :remove_picture, :avatar) }
  end

  private

  def user_not_authorized
    flash[:alert] = "This message is not yours!"
    redirect_to(request.referrer || root_path)
  end
end
