class RootController < ApplicationController
  def index
    @gists = @current_user.gists
    logger
  end
end
