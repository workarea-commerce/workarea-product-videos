Workarea Product Videos
================================================================================

Product Videos plugin for the Workarea platform.
Allows an admin user to add videos to any product!

Video embed support
--------------------------------------------------------------------------------

This plugin supports embed codes from Vimeo and Youtube.
Adding support for other video hosts would require customization of the video_embed_parser
service.
We do not host video content, and therefor do not offer an option to upload a video
via the admin. All videos must use an embed code.

Getting Started
--------------------------------------------------------------------------------

Add the gem to your application's Gemfile:

```ruby
# ...
gem 'workarea-product_videos'
# ...
```

Update your application's bundle.

```bash
cd path/to/application
bundle
```

Display options
--------------------------------------------------------------------------------

Out of the box we provide 3 options for displaying product videos on the storefront:
embedded, link, and thumbnail.

### Embedded

Embeds an iframe below the product description.

### Dialog

Adds a link below the product description, on click the video will open in a dialog.

### Thumbnail

Embeds a thumbnail image in the product alt-image array, thumbnail has a play icon
svg overlayed, this is trivial to customize.
When the thumbnail is clicked the video will open in a dialog
Thumbnail image can be selected in the admin via an asset picker.
If no thumbnail image is selected the first product image will be used as a fallback.

**Caveat:** Since the thumbnail image is appended to the alt image array, the product must
have more than 1 image for the video to display. This could easily be changed in
implementation, but is not within the scope of this plugin.

Workarea Commerce Documentation
--------------------------------------------------------------------------------

See [https://developer.workarea.com](https://developer.workarea.com) for Workarea Commerce documentation.

License
--------------------------------------------------------------------------------

Workarea Product Videos is released under the [Business Software License](LICENSE)
