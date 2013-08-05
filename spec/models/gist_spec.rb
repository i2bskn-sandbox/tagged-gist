require 'spec_helper'

describe Gist do
  let(:gist_o) {FactoryGirl.create(:gist)}

  describe "#owner?" do
    it "should return true if owner" do
      expect(gist_o.owner?(gist_o.user)).to be_true
    end

    it "should return false if not owner" do
      other_user = FactoryGirl.create(:user)
      expect(gist_o.owner?(other_user)).to be_false
    end

    it "should generate exception if not specified argument" do
      expect{
        gist_o.owner?
      }.to raise_error(ArgumentError)
    end
  end

  describe "#get_tag" do
    before {
      @tag1 = Tag.create!(name: "Ruby", gist_id: gist_o.id, user_id: gist_o.user.id)
      @tag2 = Tag.create!(name: "Java", gist_id: gist_o.id, user_id: gist_o.user.id)
    }

    it "should return tag object if tag exists" do
      expect(gist_o.get_tag("Ruby")).to eq(@tag1)
    end

    it "should return nil if tag not exists" do
      expect(gist_o.get_tag("JavaScript")).to be_nil
    end

    it "should generate exception if not specified argument" do
      expect{
        gist_o.get_tag
      }.to raise_error(ArgumentError)
    end
  end

  describe ".create_with_omniauth" do
    let(:user) {FactoryGirl.create(:user)}

    it "should create Gist" do
      expect{
        Gist.create_with_octokit({
          id: "12345678",
          description: "MyString",
          html_url: "MyString",
          public: "true"
        }, user)
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
