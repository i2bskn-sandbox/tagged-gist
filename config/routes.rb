TaggedGist::Application.routes.draw do
  scope "/gists" do
    controller :gists do
      get :sync, to: :sync, as: :gists_sync
      post "/:id/tagged", to: :tagged, as: :gists_tagged
      post "/:id/untagged", to: :untagged, as: :gists_untagged
      get "/:id", to: :show, as: :gists_show
    end
  end

  controller :sessions do
    get "/auth/github/callback", to: :create
    get :logout, to: :destroy, as: :signout
  end

  controller :root do
    root to: :index
  end
end
