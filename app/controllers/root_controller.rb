class RootController < ApplicationController
  # GET /
  def index
    if @current_user
      if params[:tag].nil?
        @gists = @current_user.gists.includes(:tags)
      else
        @gists = Gist.joins(:tags).where("tags.user_id = :uid AND tags.name = :name", {uid: @current_user.id, name: params[:tag]}).includes(:tags)
        @current_tag = params[:tag]
      end
      @tags = @current_user.tag_labels
    end
  end
end
