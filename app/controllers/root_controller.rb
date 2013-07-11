class RootController < ApplicationController
  def index
    user = @current_user
    # @client = Octokit::Client.new(login: user.nickname, oauth_token: user.access_token)
    # @url = "https://gist.github.com/i2bskn/e52f88524864b71696dc.js"
  end
end
