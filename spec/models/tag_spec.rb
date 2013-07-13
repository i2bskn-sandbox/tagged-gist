require 'spec_helper'

describe Tag do
  describe "validations" do
    let(:tag) {FactoryGirl.build(:tag)}

    it "should valid with valid params" do
      expect(tag).to be_valid
    end

    it "should not valid if name is nil" do
      tag.name = nil
      expect(tag).not_to be_valid
    end

    it "should not valid if name is over 20 characters" do
      tag.name = "a" * 21
      expect(tag).not_to be_valid
    end
  end
end
