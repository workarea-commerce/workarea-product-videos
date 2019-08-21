module Workarea
  class VideoEmbedParser
    def initialize(embed_code, options = {})
      @parsed_embed_code = Nokogiri::HTML.fragment(embed_code).children.first
      @options = options
    end

    def video_params
      {
        embed_id: embed_id,
        url: url,
        host: uri.host,
        aspect_ratio: aspect_ratio
      }
    end

    private

      def vimeo?
        /vimeo/.match?(host)
      end

      def youtube?
        /youtube/.match(host)
      end

      def url
        @url ||= @parsed_embed_code.attribute("src").value
      end

      def uri
        URI.parse(url)
      end

      def host
        uri.host
      end

      def embed_id
        id = uri.path.split("/").last
        if youtube?
          id = "youtube-#{id}"
        end
        id
      end

      def aspect_ratio
        height = @parsed_embed_code.attribute("height").value
        width = @parsed_embed_code.attribute("width").value
        ratio = (height.to_f / width.to_f) * 100
        ratio.round(2)
      end
  end
end
