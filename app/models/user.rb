class User < ActiveRecord::Base
  has_many :gists, dependent: :destroy
  has_many :tags, dependent: :destroy

  def tag_labels
    # tags.inject(Set.new){|labels,tag| labels.add(tag.name)}.to_a
    Tag.where(user_id: self.id).pluck(:name).uniq
  end

  def update_with_omniauth(auth)
    update_attributes!(
      nickname: auth[:info][:nickname],
      email: auth[:info][:email],
      image_url: auth[:info][:image],
      github_url: auth[:info][:urls][:GitHub],
      access_token: auth[:credentials][:token]
    )
  end

  def gists_from_tag(name)
    ids = Tag.where("user_id = ? AND name = ?", self.id, name).pluck(:gist_id)
    Gist.where("id IN (?)", ids)
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
