class GistsController < ApplicationController
  before_action :require_signin

  # GET /gists/1
  def show
    begin
      @gist = Gist.find(params[:id])

      if !@gist.public_gist && @gist.user != @current_user
        render file: "#{Rails.root}/public/500.html", status: 500, layout: false and return
      end

      @tags = @current_user.tag_labels
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html", status: 404, layout: false and return
    end
  end

  # POST /gists/tagged
  def tagged
    begin
      @gist = Gist.find(params[:gist_id])

      if @gist.owner? @current_user
        @tag = Tag.new(name: params[:name])
        @tag.user = @current_user
        @tag.gist = @gist
        if @tag.save
          @status = "Success"
        else
          @status = @tag.errors.full_messages.first
        end
      else
        @status = "Permission denied"
      end
    rescue ActiveRecord::RecordNotFound
      @status = "Gist not found"
    end
  end

  # DELETE /gists/untagged
  def untagged
    begin
      @gist = Gist.find(params[:gist_id])

      if @gist.owner? @current_user
        @tag = @gist.get_tag(params[:name])
        @tag.destroy if @tag
        @status = "Success"
      else
        @status = "Permission denied"
      end
    rescue ActiveRecord::RecordNotFound
      @status = "Gist not found"
    end
  end

  # GET /gists/sync
  def sync
    begin
      client = Octokit::Client.new(
        login: @current_user.nickname,
        oauth_token: @current_user.access_token
      )

      Gist.transaction do
        client.gists.each do |g|
          local_gist = Gist.where(gid: g[:id]).first
          if local_gist
            if local_gist.description != g[:description]
              local_gist.description = g[:description]
              local_gist.save!
            end
          else
            Gist.create_with_octokit(g, @current_user)
          end
        end
      end
      @status = "success"
    rescue => e
      @status = e.message
    end
  end
end
