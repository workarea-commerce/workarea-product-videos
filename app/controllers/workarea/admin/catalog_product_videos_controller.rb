module Workarea
  class Admin::CatalogProductVideosController < Admin::ApplicationController
    required_permissions :catalog
    before_action :find_product

    def index
      @videos = @product.videos
    end

    def new; end

    def create
      @video = @product.videos.build(params[:video])

      if @video.save
        flash[:success] = t("workarea.admin.catalog_product_videos.flash_messages.created")
        redirect_to catalog_product_videos_path(@product)
      else
        render :index, status: :unprocessable_entity
      end
    end

    def edit
      @video = @product.videos.find(params[:id])
    end

    def update
      @video = @product.videos.find(params[:id])

      if @video.update_attributes(params[:video])
        flash[:success] = t("workarea.admin.catalog_product_videos.flash_messages.updated")
      else
        flash[:error] = t("workarea.admin.catalog_product_videos.flash_messages.error")
      end

      redirect_to catalog_product_videos_path(@product)
    end

    def destroy
      @product.videos.find(params[:id]).destroy
      flash[:success] = t("workarea.admin.catalog_product_videos.flash_messages.deleted")
      redirect_to catalog_product_videos_path(@product)
    end

    private

      def find_product
        model = Catalog::Product.find_by(slug: params[:catalog_product_id])
        @product = Admin::ProductViewModel.wrap(model, view_model_options)
      end
  end
end
