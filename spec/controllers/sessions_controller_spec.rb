require 'spec_helper'

describe SessionsController do
  let(:user) {FactoryGirl.create(:user)}

  def valid_session
    {user: user.id}
  end

  describe "GET create" do
    context "with registered user" do
      before do
        User.any_instance.should_receive(:update_with_omniauth).and_return(true)
        request.env["omniauth.auth"] = {uid: user.uid}
        get :create
      end

      it "return http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to root_path" do
        expect(response).to redirect_to(root_path)
      end

      it "session should be created" do
        expect(session[:user]).to eq(user.id)
      end
    end

    context "with not registered user" do
      before do
        User.should_receive(:find_by_uid).and_return(nil)
        User.should_receive(:create_with_omniauth).and_return(user)
        request.env["omniauth.auth"] = {uid: "1"}
        get :create
      end

      it "return http redirect" do
        expect(response).to be_redirect
      end

      it "should redirect to root_path" do
        expect(response).to redirect_to(root_path)
      end

      it "session should be created" do
        expect(session[:user]).to eq(user.id)
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:user] = user.id
      get :destroy, {}, valid_session
    end

    it "returns http redirect" do
      expect(response).to be_redirect
    end

    it "should redirect to root_path" do
      expect(response).to redirect_to(root_path)
    end

    it "should clear session" do
      expect(session[:user]).to be_nil
    end
  end
end
