class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth[:uid])
    if user
      user.update_with_omniauth(auth)
    else
      user = User.create_with_omniauth(auth)
    end
    session[:user] = user.id
    redirect_to root_path, notice: "Sign in was successful."
  end

  def destroy
    session[:user] = nil
    redirect_to root_path
  end
end
