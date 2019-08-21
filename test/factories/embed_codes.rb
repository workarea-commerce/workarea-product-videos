module Workarea
  module Factories
    module EmbedCodes
      Factories.add(self)

      def vimeo_embed
        '<iframe src="https://player.vimeo.com/video/153825647" width="1367" height="769" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>'
      end

      def youtube_embed
        '<iframe width="560" height="315" src="https://www.youtube.com/embed/rSGnNMnvM6M" frameborder="0" allowfullscreen></iframe>'
      end
    end
  end
end
