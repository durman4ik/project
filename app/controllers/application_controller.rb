class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_filter :set_locale
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end

  def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

  protected

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def after_sign_in_path_for(resource)
    user_root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << [:login, :username]
    devise_parameter_sanitizer.for(:sign_up) << [:username, :avatar, :theme]
    devise_parameter_sanitizer.for(:account_update) << [:username, :avatar, :theme]
  end
end
