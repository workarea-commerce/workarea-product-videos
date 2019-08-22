$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "workarea/product_videos/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "workarea-product_videos"
  s.version     = Workarea::ProductVideos::VERSION
  s.authors     = ["F.M. Bonnevier"]
  s.email       = ["fbonnevier@weblinc.com"]
  s.homepage    = "https://github.com/workarea-commerce/workarea-product_videos"
  s.summary     = "Product Videos for the Workarea Ecommerce platform"
  s.description = "Adds youtube and vimeo video embedding to products."

  s.files = `git ls-files`.split("\n")

  s.license = 'Business Software License'

  s.add_dependency "workarea", "~> 3.x"
end
