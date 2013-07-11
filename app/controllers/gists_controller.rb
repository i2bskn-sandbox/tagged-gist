class GistsController < ApplicationController
  before_action :require_signin

  def show
    begin
      @gist = Gist.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html", status: 404, layout: false and return
    end

    if @gist.public_gist && @gist.user != @current_user
      render file: "#{Rails.root}/public/404.html", status: 404, layout: false and return
    end
  end

  def sync
    user = @current_user
    client = Octokit::Client.new(login: user.nickname, oauth_token: user.access_token)
    client.gists.each do |g|
      Gist.create_with_octokit(g, @current_user)
    end
    redirect_to root_path
  end
end
