# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    uid "MyString"
    nickname "MyString"
    email "MyString"
    image_url "MyString"
    github_url "MyString"
    access_token "MyString"
  end
end
