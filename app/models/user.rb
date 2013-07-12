class User < ActiveRecord::Base
  has_many :gists, dependent: :destroy
  has_many :tags, dependent: :destroy

  def tag_labels
    labels = Set.new
    tags.each do |tag|
      labels.add(tag.name)
    end
    labels.to_a
  end

  def update_with_omniauth(auth)
    update_attributes!(
      uid: auth[:uid],
      nickname: auth[:info][:nickname],
      email: auth[:info][:email],
      image_url: auth[:info][:image],
      github_url: auth[:info][:urls][:GitHub],
      access_token: auth[:credentials][:token]
    )
  end
  
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
