class GistsController < ApplicationController
  before_action :require_signin

  # GET /gists/1
  def show
    begin
      @gist = Gist.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html", status: 404, layout: false and return
    end

    if !@gist.public_gist && @gist.user != @current_user
      render file: "#{Rails.root}/public/404.html", status: 404, layout: false and return
    end

    @tags = get_tags(@current_user)
  end

  # POST /gists/1/tagged
  def tagged
    begin
      @gist = Gist.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html", status: 404, layout: false and return
    end

    if @gist.user != @current_user
      render file: "#{Rails.root}/public/404.html", status: 404, layout: false and return
    end

    tag = Tag.new(name: params[:name])
    tag.user = @current_user
    tag.gist = @gist

    if tag.save
      redirect_to root_path, notice: "The tagging of gist is successful."
    else
      redirect_to root_path, alert: tag.errors.full_messages.first
    end
  end

  # DELETE /gists/1/untagged
  def untagged
    begin
      @gist = Gist.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html", status: 404, layout: false and return
    end

    tag = Tag.where("user_id = :uid AND gist_id = :gid AND name = :name", {uid: @current_user.id, gid: @gist.id, name: params[:name]})
    tag.first.destroy
    redirect_to root_path, notice: "The untagging of gist is successful."
  end

  # GET /gists/sync
  def sync
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

    redirect_to root_path
  end
end
