class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth[:uid]) || User.create_with_omniauth(auth)
    session[:user] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user] = nil
    redirect_to root_path
  end
end
