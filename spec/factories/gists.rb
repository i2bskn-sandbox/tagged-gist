# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gist, class: Gist do
    sequence(:gid) {|n| "%07d" % n}
    description "MyString"
    html_url "MyString"
    embed_url "MyString"
    public_gist true
    user
  end
end
