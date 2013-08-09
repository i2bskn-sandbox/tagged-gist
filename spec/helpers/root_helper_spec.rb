require 'spec_helper'

describe RootHelper do
  describe "#public_attribute" do
    it "should returns public if public gist" do
      expect(helper.public_attribute(FactoryGirl.create(:gist))).to eq("public")
    end

    it "should returns private if private gist" do
      expect(helper.public_attribute(FactoryGirl.create(:private_gist))).to eq("private")
    end
  end
end
