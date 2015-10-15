class SitesController < ApplicationController
  def index
    @sites = Site.all
  end

  def show
    @site = Site.find(params[:id])
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
      if @site.save
        require 'open-uri'
        @doc = Nokogiri::HTML(open("http://www.google.com"))
        @links = @doc.css("a")
        redirect_to site_path(@site)
      else
        render :new
      end
  end

private
  def site_params
    params.require(:site).permit(:url)
  end
end
