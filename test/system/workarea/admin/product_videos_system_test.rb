require "test_helper"

module Workarea
  module Admin
    class ProductVideosSystemTest < Workarea::SystemTest
      include Admin::IntegrationTest

      def test_managing_videos
        product = create_product
        visit admin.catalog_product_path(product)
        click_link t("workarea.admin.catalog_products.cards.videos.title")

        assert(page.has_content?(t("workarea.admin.catalog_product_videos.index.heading")))
        click_link t("workarea.admin.catalog_product_videos.index.add_new")

        fill_in "video[embed_code]", with: youtube_embed
        select "embedded", from: "video[display_option]"
        click_button "create_video"

        assert_equal(admin.catalog_product_videos_path(product), current_path)
        assert(page.has_content?("Success"))
        assert(page.has_content?("embedded"))

        click_button "delete_video"

        assert_equal(admin.catalog_product_videos_path(product), current_path)
        assert(page.has_content?("Success"))
        refute(page.has_content?("embedded"))
      end

      def test_creating_a_product_video_with_thumbnail
        asset = create_asset
        product = create_product
        visit admin.catalog_product_path(product)
        click_link t("workarea.admin.catalog_products.cards.videos.title")

        assert(page.has_content?(t("workarea.admin.catalog_product_videos.index.heading")))
        click_link t("workarea.admin.catalog_product_videos.index.add_new")

        fill_in "video[embed_code]", with: youtube_embed
        select "thumbnail", from: "video[display_option]"
        find(".asset-picker-field a").click
        within "#takeover" do
          click_link "Test Asset"
        end

        within ".asset-picker-field" do
          assert(page.has_content?("Test Asset"))
        end
        click_button "create_video"

        assert_equal(admin.catalog_product_videos_path(product), current_path)
        assert(page.has_content?("Success"))
        assert(page.has_content?("thumbnail"))
      end
    end
  end
end
