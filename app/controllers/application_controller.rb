class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :admin_logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def admin_logged_in?
    logged_in? and current_user.admin?
  end

  def require_user
    access_denied unless logged_in?
  end

  def require_admin
    access_denied unless admin_logged_in?
  end

  def access_denied
    flash[:error] = "You don't have access to that."
    redirect_to root_path
    end
end
