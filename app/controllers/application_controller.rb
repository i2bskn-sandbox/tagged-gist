class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  private
  def current_user
    @current_user ||= User.find_by_id(session[:user]) if session[:user]
  end

  def require_signin
    unless current_user
      render file: "#{Rails.root}/public/404.html", status: 404, layout: false
    end
  end
end
