module RootHelper
  def public_attribute(g)
    return g.public_gist ? "public" : "private"
  end
end
