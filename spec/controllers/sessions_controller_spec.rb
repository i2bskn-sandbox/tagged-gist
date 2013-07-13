require 'spec_helper'

describe SessionsController do
  let(:user) {FactoryGirl.create(:user)}

  def valid_session
    {user: user.id}
  end

  describe "GET destroy" do
    it "returns http redirect" do
      get :destroy, {}, valid_session
      expect(response).to be_redirect
    end

    it "should redirect to root_path" do
      get :destroy, {}, valid_session
      expect(response).to redirect_to(root_path)
    end

    it "should clear session" do
      session[:user] = user.id
      get :destroy, {}, valid_session
      expect(session[:user]).to be_nil
    end
  end
end
