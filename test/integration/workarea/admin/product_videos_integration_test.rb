require "test_helper"

module Workarea
  module Admin
    class ProductVideosIntegrationTest < Workarea::IntegrationTest
      include Admin::IntegrationTest
      setup :set_product

      def set_product
        @product = create_product
      end

      def test_creates_a_video
        post admin.catalog_product_videos_path(@product),
             params: { video: { embed_code: youtube_embed, display_option: "embedded" } }

        @product.reload
        video = @product.videos.first
        assert_equal(1, @product.videos.length)
        assert_equal("embedded", video.display_option)
        assert_equal("youtube-rSGnNMnvM6M", video.embed_id)
        assert_equal("https://www.youtube.com/embed/rSGnNMnvM6M", video.url)
        assert_equal("www.youtube.com", video.host)
        assert_equal("56.25", video.aspect_ratio)
      end

      def test_updates_video
        video = @product.videos.create!(
          embed_code: youtube_embed,
          display_option: "embedded"
        )

        patch admin.catalog_product_video_path(@product, video),
             params: { video: { embed_code: youtube_embed, display_option: "dialog" } }

        @product.reload
        video = @product.videos.first
        assert_equal(1, @product.videos.length)
        assert_equal("youtube-rSGnNMnvM6M", video.embed_id)
        assert_equal("https://www.youtube.com/embed/rSGnNMnvM6M", video.url)
        assert_equal("www.youtube.com", video.host)
        assert_equal("56.25", video.aspect_ratio)
        assert_equal("dialog", video.display_option)
      end

      def test_destroys_a_video
        video = @product.videos.create!(
          embed_code: youtube_embed,
          display_option: "embedded"
        )

        delete admin.catalog_product_video_path(@product, video)

        @product.reload
        assert_empty(@product.videos)
      end
    end
  end
end
