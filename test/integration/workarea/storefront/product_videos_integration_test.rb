require "test_helper"

module Workarea
  module Storefront
    class ProductVideosIntegrationTest < Workarea::IntegrationTest
      include Storefront::IntegrationTest

      def inactive_product
        @inactive_product = create_product(
          active: false,
          videos: [{ _id: "test-video", embed_code: youtube_embed, display_option: "embedded" }]
        )
      end

      def test_does_not_show_video_for_an_inactive_product
        assert_raise InvalidDisplay do
          get storefront.product_video_path(inactive_product.id, inactive_product.videos.first.id)
          assert(response.not_found?)
        end
      end

      def test_admin_user_can_view_videos_for_inactive_product
        set_current_user(create_user(admin: true))

        get storefront.product_video_path(inactive_product.id, inactive_product.videos.first.id)
        assert(response.ok?)
      end
    end
  end
end
