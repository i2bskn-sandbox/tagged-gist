# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, class: User do
    sequence(:uid) {|n| "%07d" % n}
    sequence(:nickname) {|n| "user#{n}"}
    email "MyString"
    image_url "MyString"
    github_url "MyString"
    access_token "MyString"
  end
end
