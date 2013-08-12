class RootController < ApplicationController
  # GET /
  def index
    @current_tag = params[:tag]

    if @current_user
      if @current_tag.nil?
        @gists = @current_user.gists.includes(:tags)
      else
        @gists = @current_user.gists_from_tag(@current_tag).includes(:tags)
      end

      @tags = @current_user.tag_labels
    end
  end
end
