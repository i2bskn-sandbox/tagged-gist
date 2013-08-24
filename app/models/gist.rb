class Gist < ActiveRecord::Base
  has_many :tags, dependent: :destroy
  belongs_to :user

  def owner?(user)
    self.user == user
  end

  def get_tag(name)
    self.tags.each do |tag|
      return tag if tag.name == name
    end
    return nil
  end

  class << self
    def create_with_octokit(octokit_gist, user)
      create! do |g|
        g.gid = octokit_gist[:id]
        g.description = octokit_gist[:description]
        g.public_gist = octokit_gist[:public]
        g.html_url = "https://gist.github.com/#{user.nickname}/#{octokit_gist[:id]}"
        g.embed_url = "https://gist.github.com/#{user.nickname}/#{octokit_gist[:id]}.js"
        g.user_id = user.id
      end
    end
  end
end
