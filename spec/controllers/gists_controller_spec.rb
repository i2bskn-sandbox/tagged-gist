require 'spec_helper'

describe GistsController do
  describe "GET show" do
    let(:gist_object) {FactoryGirl.create(:gist)}

    context "with sign in" do
      let!(:tag) do
        tag = Tag.create!(name: "tag", user_id: gist_object.user.id, gist_id: gist_object.id)
        get :show, {id: gist_object.id}, {user: gist_object.user.id}
        tag
      end

      it "return http success" do
        expect(response).to be_success
      end

      it "assigns current_user as user" do
        expect(assigns(:current_user)).to eq(gist_object.user)
      end

      it "assigns tags as tag" do
        expect(assigns(:tags)).to eq([tag.name])
      end
    end

    context "with not sign in" do
      it "return http 404 if not sign in" do
        get :show, {id: gist_object.id}
        expect(response.status).to eq(404)
      end
    end

    context "with bad request" do
      it "return http 404 if not exists gist" do
        Gist.should_receive(:find).and_raise(ActiveRecord::RecordNotFound)
        get :show, {id: gist_object.id}, {user: gist_object.user.id}
        expect(response.status).to eq(404)
      end

      it "return http 404 if othor user's private gist" do
        g = FactoryGirl.create(:gist)
        g.update_attributes!(public_gist: false)
        get :show, {id: g.id}, {user: gist_object.user.id}
        expect(response.status).to eq(404)
      end
    end
  end
end
