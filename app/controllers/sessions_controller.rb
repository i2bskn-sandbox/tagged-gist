class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    raise auth[:provider]
  end
end
