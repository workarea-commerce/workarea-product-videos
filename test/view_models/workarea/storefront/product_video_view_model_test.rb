require "test_helper"

module Workarea
  module Storefront
    class ProductVideoViewModelTest < TestCase
      def test_iframe_attrs_for_all_videos
        @product = create_product(
          name: "test",
          videos: [{ embed_code: youtube_embed, display_option: "embedded" }]
        )

        view_model = ProductVideoViewModel.wrap(@product.videos.first)
        assert_equal("youtube-rSGnNMnvM6M", view_model.iframe_attrs[:id])
        assert_equal("0", view_model.iframe_attrs[:frameborder])
        assert_equal("padding-bottom: 56.25%", view_model.iframe_attrs[:container_style])
        assert_equal("", view_model.iframe_attrs[:allowfullscreen])
      end

      def test_iframe_attrs_for_youtube_videos
        @product = create_product(
          name: "test",
          videos: [{ embed_code: youtube_embed, display_option: "embedded" }]
        )

        view_model = ProductVideoViewModel.wrap(@product.videos.first)
        assert_equal("https://www.youtube.com/embed/rSGnNMnvM6M?enablejsapi=1&autoplay=0&loop=0&videoId=youtube-rSGnNMnvM6M", view_model.iframe_attrs[:src])
        assert(view_model.iframe_attrs[:data].key?(:youtube_api))
      end

      def test_iframe_attrs_for_youtube_video
        @product = create_product(
          name: "vimeo test",
          videos: [{ embed_code: vimeo_embed, display_option: "embedded" }]
        )

        view_model = ProductVideoViewModel.wrap(@product.videos.first)
        assert_equal("153825647", view_model.iframe_attrs[:id])
        assert_equal("padding-bottom: 56.25%", view_model.iframe_attrs[:container_style])
        assert_equal("https://player.vimeo.com/video/153825647?api=1&autoplay&loop&player_id=153825647", view_model.iframe_attrs[:src])
        assert_equal("", view_model.iframe_attrs[:webkitallowfullscreen])
        assert_equal("", view_model.iframe_attrs[:mozallowfullscreen])
        assert(view_model.iframe_attrs[:data].key?(:vimeo_api))
      end
    end
  end
end
