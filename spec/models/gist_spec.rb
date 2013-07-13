require 'spec_helper'

describe Gist do
  def valid_gist
    {
      id: "12345678",
      description: "MyString",
      html_url: "MyString",
      public: "true"
    }
  end

  let(:user) {FactoryGirl.create(:user)}

  describe ".create_with_omniauth" do
    it "should create Gist" do
      expect{
        Gist.create_with_octokit(valid_gist, user)
      }.to change(Gist, :count).by(1)
    end

    it "exception should be generated if not arguments" do
      expect{Gist.create_with_octokit}.to raise_error(ArgumentError)
    end

    it "exception should be generated if argument is nil" do
      expect{Gist.create_with_octokit(nil, user)}.to raise_error(NoMethodError)
    end
  end
end
