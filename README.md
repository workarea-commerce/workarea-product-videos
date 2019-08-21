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

Getting Started
--------------------------------------------------------------------------------

This gem contains a rails engine that must be mounted onto a host Rails application.

To access Workarea gems and source code, you must be an employee of WebLinc or a licensed retailer or partner.

Workarea gems are hosted privately at https://gems.weblinc.com/.
You must have individual or team credentials to install gems from this server. Add your gems server credentials to Bundler:

    bundle config gems.weblinc.com my_username:my_password

Or set the appropriate environment variable in a shell startup file:

    export BUNDLE_GEMS__WEBLINC__COM='my_username:my_password'

Then add the gem to your application's Gemfile specifying the source:

    # ...
    gem 'workarea-product_videos', source: 'https://gems.weblinc.com'
    # ...

Or use a source block:

    # ...
    source 'https://gems.weblinc.com' do
      gem 'workarea-product_videos'
    end
    # ...

Update your application's bundle.

    cd path/to/application
    bundle

Workarea Platform Documentation
--------------------------------------------------------------------------------

See [http://developer.weblinc.com](http://developer.weblinc.com) for Workarea platform documentation.

Copyright & Licensing
--------------------------------------------------------------------------------

Copyright WebLinc 2017. All rights reserved.

For licensing, contact sales@workarea.com.
