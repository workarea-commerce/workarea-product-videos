require "test_helper"

module Workarea
  class VideoEmbedParserTest < TestCase
    def options
      { autoplay: true, loop_playback: true }
    end

    def test_video_params_returns_additional_data_from_embed_code_youtube
      view_model = VideoEmbedParser.new(youtube_embed, options)

      assert("youtube-rSGnNMnvM6M", view_model.video_params[:embed_id])
      assert("https://www.youtube.com/embed/rSGnNMnvM6M", view_model.video_params[:url])
      assert("www.youtube.com", view_model.video_params[:host])
      assert("56.25", view_model.video_params[:aspect_ratio])
    end

    def test_video_params_returns_additional_data_from_embed_code_vimeo
      view_model = VideoEmbedParser.new(vimeo_embed, options)

      assert("153825647", view_model.video_params[:embed_id])
      assert("https://player.vimeo.com/video/153825647", view_model.video_params[:url])
      assert("/player.vimeo.com", view_model.video_params[:host])
      assert("56.25", view_model.video_params[:aspect_ratio])
    end
  end
end
