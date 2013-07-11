TaggedGist::Application.routes.draw do
  controller :sessions do
    get "/auth/github/callback", to: :create
  end

  controller :root do
    root to: :index
  end
end
