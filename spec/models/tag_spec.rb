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

    it "should not valid if duplicated tag" do
      Tag.create!(name: tag.name, user_id: tag.user_id, gist_id: tag.gist_id)
      expect(tag).not_to be_valid
    end
  end

  describe ".duplicate?" do
    it "should return nil if not exists" do
      g = FactoryGirl.create(:gist)
      expect(Tag.duplicate?(name: "not_exists", user: g.user.id, gist: g.id)).to be_nil
    end

    it "should not return nil if exists" do
      t = FactoryGirl.create(:tag)
      expect(Tag.duplicate?(name: t.name, user: t.user_id, gist: t.gist_id)).to eq(1)
    end
  end
end
