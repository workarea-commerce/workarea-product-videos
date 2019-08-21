Workarea::Storefront::Engine.routes.draw do
  scope "(:locale)", constraints: Workarea::I18n.routes_constraint do
    resources :products, only: [:show] do
      get "video/:video_id", to: "products#video", as: :video
    end
  end
end

Workarea::Admin::Engine.routes.draw do
  scope "(:locale)", constraints: Workarea::I18n.routes_constraint do
    resources :catalog_products, only: [:index] do
      resources :videos, controller: "catalog_product_videos"
    end
  end
end
