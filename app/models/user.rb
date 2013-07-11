class User < ActiveRecord::Base
  class << self
    def create_with_omniauth(auth)
      create! do |user|
        user.uid = auth[:uid]
        user.nickname = auth[:info][:nickname]
        user.email = auth[:info][:email]
        user.image_url = auth[:info][:image]
        user.github_url = auth[:info][:urls][:GitHub]
        user.access_token = auth[:credentials][:token]
      end
    end
  end
end
