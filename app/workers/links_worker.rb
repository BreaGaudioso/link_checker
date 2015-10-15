class LinksWorker
  include Sidekiq::Worker

  def perform(site_id)
    site = Site.find(site_id)
    doc = Nokogiri::HTML(open("#{site.url}"))
    links = doc.css('a')
    links.each do |link|
      l = link['href']
      if (l.first == '/')
        l = (site.url + l)
      end
      if (l.starts_with? 'http://', 'https://')
        res = Typhoeus.get(l)
        site.links.create(link_url: l, http_response: res.response_code)
      end
    end
  end
end