require 'spec_helper'

describe ApplicationController do
  let(:user) {FactoryGirl.create(:user)}

  describe "#current_user" do
    controller do
      def index
        render nothing: true
      end
    end

    context "with sign in" do
      it "returns user" do
        get :index, {}, {user: user.id}
        expect(assigns(:current_user)).to eq(user)
      end
    end

    context "with not sign in" do
      it "returns nil" do
        get :index
        expect(assigns(:current_user)).to be_nil
      end
    end
  end

  describe "#require_signin" do
    controller do
      before_action :require_signin
      def index
        render nothing: true
      end
    end

    context "with sign in" do
      it "returns http success" do
        get :index, {}, {user: user.id}
        expect(response).to be_success
      end
    end

    context "with not sign in" do
      it "returns server internal error" do
        get :index
        expect(response.status).to eq(500)
      end
    end
  end
end
