require 'spec_helper'

describe GistsController do
  let(:gist_object) {FactoryGirl.create(:gist)}

  describe "GET show" do
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
        get :show, {id: 1}, {user: gist_object.user.id}
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

  describe "POST tagged" do
    context "with sign in" do
      it "requested tag should be created" do
        g = gist_object
        expect {
          post :tagged, {id: g.id, name: "MyString"}, {user: g.user.id}
        }.to change(Tag, :count).by(1)
      end

      it "return http redirect" do
        post :tagged, {id: gist_object.id, name: "MyString"}, {user: gist_object.user.id}
        expect(response).to be_redirect
      end

      it "should redirect to root_path" do
        post :tagged, {id: gist_object.id, name: "MyString"}, {user: gist_object.user.id}
        expect(response).to redirect_to(root_path)
      end

      it "new tag should not created if invalid name" do
        g = gist_object
        expect {
          post :tagged, {id: g.id, name: "invalid_name_of_tag_over_20_characters"}, {user: g.user.id}
        }.not_to change(Tag, :count)
      end

      it "return http redirect if invalid name" do
        post :tagged, {id: gist_object.id, name: "invalid_name_of_tag_over_20_characters"}, {user: gist_object.user.id}
        expect(response).to be_redirect
      end

      it "should redirect to root_path if invalid name" do
        post :tagged, {id: gist_object.id, name: "invalid_name_of_tag_over_20_characters"}, {user: gist_object.user.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context "with not sign in" do
      it "return http 404 if not sign in" do
        post :tagged, {id: gist_object.id, name: "MyString"}
        expect(response.status).to eq(404)
      end
    end

    context "with bad request" do
      it "return http 404 if not exists gist" do
        Gist.should_receive(:find).and_raise(ActiveRecord::RecordNotFound)
        post :tagged, {id: 1, name: "MyString"}, {user: gist_object.user.id}
        expect(response.status).to eq(404)
      end

      it "return http 404 if othor user's gist" do
        g = FactoryGirl.create(:gist)
        post :tagged, {id: g.id, name: "MyString"}, {user: gist_object.user.id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "DELETE untagged" do
    let!(:tag) {FactoryGirl.create(:tag)}

    context "with sign in" do
      it "request tag should be deleted" do
        expect {
          delete :untagged, {id: tag.gist.id, name: tag.name}, {user: tag.user.id}
        }.to change(Tag, :count).by(-1)
      end

      it "return http redirect" do
        delete :untagged, {id: tag.gist.id, name: tag.name}, {user: tag.user.id}
        expect(response).to be_redirect
      end

      it "should redirect to root_path" do
        delete :untagged, {id: tag.gist.id, name: tag.name}, {user: tag.user.id}
        expect(response).to redirect_to(root_path)
      end
    end

    context "with not sign in" do
      it "return http 404 if not sign in" do
        expect {
          delete :untagged, {id: tag.gist.id, name: tag.name}
        }.not_to change(Tag, :count)
        expect(response.status).to eq(404)
      end

      it "Tag.where should not called" do
        Tag.should_not_receive(:where)
        delete :untagged, {id: tag.gist.id, name: tag.name}
      end
    end

    context "with bad request" do
      it "return http 404 if not exists gist" do
        Gist.should_receive(:find).and_raise(ActiveRecord::RecordNotFound)
        delete :untagged, {id: tag.gist.id, name: tag.name}, {user: tag.user.id}
        expect(response.status).to eq(404)
      end
    end
  end

  describe "GET sync" do
    context "with sign in" do
      before {request.env["HTTP_ACCEPT"] = 'application/json'}
      let(:client) {double("client mock").as_null_object}
      
      it "return http success" do
        client.should_receive(:gists).and_return([])
        Octokit::Client.should_receive(:new).and_return(client)
        get :sync, {}, {user: gist_object.user.id}
        expect(response).to be_success
      end

      it "Gist#save! should be called" do
        gist_mock = double("gist mock").as_null_object
        gist_mock.should_receive(:save!).exactly(3)
        gist_mock.stub(:description).and_return("old content")
        client.should_receive(:gists).and_return([{id: 1}, {id: 2}, {id: 3}])
        Octokit::Client.should_receive(:new).and_return(client)
        Gist.stub(:where).and_return([gist_mock])
        get :sync, {}, {user: gist_object.user.id}
      end

      it "Gist.create_with_octokit should be called" do
        client.should_receive(:gists).and_return([{id: 1}, {id: 2}, {id: 3}])
        Octokit::Client.should_receive(:new).and_return(client)
        Gist.stub(:where).and_return([false])
        Gist.should_receive(:create_with_octokit).exactly(3)
        get :sync, {}, {user: gist_object.user.id}
      end

      it "@status should be a message if exception occurs" do
        Octokit::Client.should_receive(:new).and_raise("error")
        get :sync, {}, {user: gist_object.user.id}
        expect(assigns(:status)).to eq("error")
      end
    end

    context "with not sign in" do
      it "return http 404 if not sign in" do
        get :sync
        expect(response.status).to eq(404)
      end
    end
  end
end
