module Workarea
  module ProductVideos
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::ProductVideos
    end
  end
end
