module Workarea
  module Storefront
    class ProductVideoViewModel < ApplicationViewModel
      def iframe_attrs
        attrs = {
          id: model.embed_id,
          frameborder: "0",
          allowfullscreen: "",
          container_style: "padding-bottom: #{model.aspect_ratio}%"
        }

        if vimeo?
          attrs.merge(vimeo_attrs)
        elsif youtube?
          attrs.merge(youtube_attrs)
        end
      end

      def thumbnail
        return unless model.thumbnail.present?
        @thumbnail ||= Workarea::Content::Asset.find_or_initialize_by(id: model.thumbnail)
      end

      private

        def vimeo?
          /vimeo/.match?(host)
        end

        def youtube?
          /youtube/.match?(host)
        end

        def vimeo_attrs
          {
            src: "#{model.url}?#{vimeo_url_params}",
            webkitallowfullscreen: "",
            mozallowfullscreen: "",
            data: {
              vimeo_api: {
                player_id: model.embed_id,
                mute: @options[:mute]
              }.to_json
            }
          }
        end

        def youtube_attrs
          {
            src: "#{url}?#{youtube_url_params}",
            data: {
              youtube_api: {
                mute: @options[:mute]
              }.to_json
            }
          }
        end

        def uri
          URI.parse(model.url)
        end

        def vimeo_url_params
          parsed_query = Rack::Utils.parse_query(uri.query)
          parsed_query["api"] = 1
          parsed_query["autoplay"] = @options[:autoplay]
          parsed_query["loop"] = @options[:loop_playback]
          parsed_query["player_id"] = model.embed_id

          URI.encode_www_form(parsed_query)
        end

        def youtube_url_params
          parsed_query = Rack::Utils.parse_query(uri.query)
          parsed_query["enablejsapi"] = 1
          parsed_query["autoplay"] = @options[:autoplay] ? 1 : 0
          parsed_query["loop"] = @options[:loop_playback] ? 1 : 0
          parsed_query["videoId"] = model.embed_id

          URI.encode_www_form(parsed_query)
        end
    end
  end
end
