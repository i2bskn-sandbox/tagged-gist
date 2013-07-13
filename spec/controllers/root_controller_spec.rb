require 'spec_helper'

describe RootController do
  let(:user) {FactoryGirl.create(:user)}

  def valid_session
    {user: user.id}
  end

  describe "GET index" do
    context "with not sign in" do
      it "returns http success" do
        get :index
        expect(response).to be_success
      end

      it "User#tag_labels should not be called" do
        User.any_instance.should_not_receive(:tag_labels)
        get :index
      end
    end

    context "with sign in" do
      let!(:tags) do
        tags = ["ruby", "javascript"]
        tags.each_with_index do |tag, i|
          g = Gist.new(gid: "#{Time.now.usec}#{i}", user_id: user.id)
          Tag.create!(name: tag, user_id: user.id, gist_id: g.id)
        end
        tags
      end

      it "return http success" do
        get :index, {}, valid_session
        expect(response).to be_success
      end

      it "assigns tags as all tag labels" do
        get :index, {}, valid_session
        expect(assigns(:tags)).to eq(tags)
      end

      it "assigns gists as all gists" do
        get :index, {}, valid_session
        expect(assigns(:gists)).to eq(user.gists)
      end

      it "assigns gists as specified tag" do
        get :index, {tag: "ruby"}, valid_session
        assigns(:gists).each do |g|
          expect(g.tags.inject(false){|f,t| f = true if t.name == "ruby"}).to be_true
        end
      end

      it "assigns current_tag as nil" do
        get :index, {}, valid_session
        expect(assigns(:current_tag)).to be_nil
      end

      it "assigns current_tag as specified tag" do
        get :index, {tag: "ruby"}, valid_session
        expect(assigns(:current_tag)).not_to be_nil
      end
    end
  end

end
