module Workarea
  module Catalog
    class ProductVideo
      include ApplicationDocument

      field :embed_code, type: String
      field :display_option, type: String, default: "dialog"
      field :embed_id, type: String
      field :url, type: String
      field :host, type: String
      field :aspect_ratio, type: String
      field :thumbnail, type: String

      embedded_in :product,
                  class_name: "Workarea::Catalog::Product",
                  inverse_of: :videos,
                  touch:      true

      validates :embed_code, presence: true
      validates :display_option, presence: true
      validates :embed_id, presence: true
      validates :url, presence: true
      validates :host, presence: true
      validates :aspect_ratio, presence: true
      before_validation :process_embed_code

      def process_embed_code
        VideoEmbedParser.new(self.embed_code).video_params.each { |key, value| self[key] = value }
      end
    end
  end
end
