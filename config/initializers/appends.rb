module Workarea
  should_append_video_api_modules = proc do
    if Plugin.javascripts_appends["storefront.modules"].nil?
      true
    else
      Plugin.javascripts_appends["storefront.modules"].none? { |append| %r{/modules/youtube_api} =~ append }
    end
  end

  Plugin.append_partials(
    "admin.catalog_product_cards",
    "workarea/admin/catalog_products/product_videos_card"
  )

  Plugin.append_partials(
    "storefront.product_description",
    "workarea/storefront/products/video_link"
  )

  Plugin.append_partials(
    "storefront.product_details_alt_images",
    "workarea/storefront/products/video_thumbnail"
  )

  if should_append_video_api_modules.call
    Plugin.append_javascripts(
      "storefront.modules",
      "workarea/storefront/product_videos/modules/youtube_api",
      "workarea/storefront/product_videos/modules/vimeo_api"
    )
  end

  Plugin.append_stylesheets(
    "storefront.components",
    "workarea/storefront/product_videos/components/product_video",
  )
end
