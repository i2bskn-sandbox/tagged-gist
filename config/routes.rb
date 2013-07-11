TaggedGist::Application.routes.draw do
  controller :sessions do
    get "/auth/github/callback", to: :create
    get :logout, to: :destroy, as: :signout
  end

  controller :root do
    root to: :index
  end
end
