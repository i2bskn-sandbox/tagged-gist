require 'spec_helper'

describe User do
  def valid_auth
    {
      uid: "12345678",
      info: {
        nickname: "example",
        email: "user@example.com",
        image: "image_url",
        urls: {
          GitHub: "github_url"
        }
      },
      credentials: {
        token: "oauth_token"
      }
    }
  end

  describe ".create_with_omniauth" do
    it "should create requested user" do
      expect{
        User.create_with_omniauth(valid_auth)
      }.to change(User, :count).by(1)
    end

    it "exception should be generated if not arguments" do
      expect{User.create_with_omniauth}.to raise_error(ArgumentError)
    end

    it "exception should be generated if argument is nil" do
      expect{User.create_with_omniauth(nil)}.to raise_error(NoMethodError)
    end
  end

  describe "#tag_labels" do
    let!(:user) do
      user = FactoryGirl.create(:user)
      ["ruby", "perl", "php", "python", "java", "c"].each_with_index do |t,i|
        2.times do |x|
          g = Gist.create!(
            gid: "#{x.to_s}#{i.to_s}",
            description: "MyString",
            html_url: "MyString",
            embed_url: "MyString",
            public_gist: true,
            user_id: user.id
          )
          Tag.create!(name: t, user_id: user.id, gist_id: g.id)
        end
      end
      user
    end

    it "should get labels" do
      expect(user.tag_labels).to eq(["ruby", "perl", "php", "python", "java", "c"])
    end

    it "should return empty array if user don't have tags" do
      user = FactoryGirl.create(:user)
      expect(user.tag_labels).to be_empty
    end
  end

  describe "#update_with_omniauth" do
    let!(:user) {FactoryGirl.create(:user)}

    it "nickname should be updated" do
      expect {
        user.update_with_omniauth(valid_auth)
      }.to change(user, :nickname)
    end

    it "email should be updated" do
      expect {
        user.update_with_omniauth(valid_auth)
      }.to change(user, :email)
    end

    it "image_url should be updated" do
      expect {
        user.update_with_omniauth(valid_auth)
      }.to change(user, :image_url)
    end

    it "github_url should be updated" do
      expect {
        user.update_with_omniauth(valid_auth)
      }.to change(user, :github_url)
    end

    it "access_token should be updated" do
      expect {
        user.update_with_omniauth(valid_auth)
      }.to change(user, :access_token)
    end

    it "exception should be generated if not arguments" do
      expect{user.update_with_omniauth}.to raise_error(ArgumentError)
    end

    it "exception should be generated if argument is nil" do
      expect{user.update_with_omniauth(nil)}.to raise_error(NoMethodError)
    end
  end
end
