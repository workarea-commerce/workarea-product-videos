require "workarea/testing/teaspoon"

Teaspoon.configure do |config|
  config.root = Workarea::ProductVideos::Engine.root
  Workarea::Teaspoon.apply(config)
end
