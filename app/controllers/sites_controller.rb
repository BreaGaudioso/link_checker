class SitesController < ApplicationController
  def index
    @sites = Site.all
  end

  def show
    @site = Site.find(params[:id])
    @links = @site.links
  end


  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      LinksWorker.perform_async(@site.id)
      redirect_to sites_path
    else render :new
    end
  end

private
  def site_params
   params.require(:site).permit(:url)
  end
  helper_method :site_params
end
