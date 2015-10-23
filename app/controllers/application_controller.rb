class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_locale
  def default_url_options(options = {})
    {locale: I18n.locale}
  end
  private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :image) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password, :image, :remove_image) }
  end

end
