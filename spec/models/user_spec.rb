require 'spec_helper'

describe User do
  def valid_auth
    {
      uid: "12345678",
      info: {
        nickname: "example",
        email: "MyString",
        image: "MyString",
        urls: {
          GitHub: "MyString"
        }
      },
      credentials: {
        token: "MyString"
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
end
