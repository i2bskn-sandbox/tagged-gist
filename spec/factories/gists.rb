# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gist, class: Gist do
    sequence(:gid) {|n| "%07d" % n}
    description "public gist"
    html_url "https://gist.github.com/example"
    embed_url "https://gist.github.com/example/embed.js"
    public_gist true
    user
  end

  factory :private_gist, class: Gist do
    sequence(:gid) {|n| "p%07d" % n}
    description "private_gist"
    html_url "https://gist.github.com/example"
    embed_url "https://gist.github.com/example/embed.js"
    public_gist false
    user
  end
end
