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
      require 'open-uri'
      url = site_params[:url]
      doc = Nokogiri::HTML(open("#{url}"))
      links = doc.css('a')
      links.each do |link|
        l = link['href']
        if (l.first == '/')
          l = (@site.url + l)
        end

        if (l.starts_with? 'http://', 'https://')
          res = Typhoeus.get(l)
          Site.links.create(link_url: l, http_response: res.response_code)
        end
      end
      redirect_to site_path(@site)
    else render :new
    end
  end

private
def site_params
  params.require(:site).permit(:url)
end
end
