require "test_helper"

module Workarea
  module Storefront
    class ProductVideosSystemTest < Workarea::SystemTest
      include Storefront::SystemTest

      def test_showing_embedded_videos_on_product_detail_page
        product = create_product(
          name: "Awesome Product with embedded video",
          videos: [{ embed_code: youtube_embed, display_option: "embedded" }]
        )

        visit storefront.product_path(product)

        assert(page.has_selector?("iframe.product-video__iframe"))
      end

      def test_showing_dialog_videos_on_product_detail_page
        product = create_product(
          name: "Awesome Product with dialog video",
          videos: [{ embed_code: youtube_embed, display_option: "dialog" }]
        )

        visit storefront.product_path(product)

        assert(page.has_content?(t("workarea.storefront.products.watch_this_video")))

        click_link t("workarea.storefront.products.watch_this_video")
        wait_for_xhr

        assert(page.has_selector?("iframe.product-video__iframe"))
      end

      def test_showing_thumbnail_videos_on_product_detail_page
        product = create_product(
          name: "Awesome Product with thumbnail video",
          videos: [{ embed_code: youtube_embed, display_option: "thumbnail" }]
        )

        product.images.build(image: product_image_file_path, option: "green", position: 0).save
        product.images.build(image: product_image_file_path, option: "red", position: 1).save
        product.save

        visit storefront.product_path(product)

        assert(page.has_selector?(".product-video__thumbnail"))
        refute(page.has_selector?("iframe.product-video__iframe"))

        within ".product-details__alt-images" do
          page.find(".product-video--thumbnail").click
        end

        wait_for_xhr

        assert(page.has_selector?("iframe.product-video__iframe"))
      end
    end
  end
end
