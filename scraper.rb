require 'open-uri'
require 'nokogiri'

USER_AGENT = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"

def fetch_top_movie_urls
  top_movies_url = 'https://www.imdb.com/chart/top/'
  html_file = URI.open(top_movies_url, 'Accept-Language' => 'en-US', 'User-Agent' => USER_AGENT).read
  doc = Nokogiri::HTML(html_file)

  links = []
  # TODO: return top movies URLs
  doc.search('a.ipc-title-link-wrapper').first(5).each do |link|
    links << "https://www.imdb.com" + link.attribute('href').value.gsub(/\?.*$/,'')
  end

  links
end

def scrape_movie(url)
  html_file = URI.open(url, 'Accept-Language' => 'en-US', 'User-Agent' => USER_AGENT).read
  doc = Nokogiri::HTML(html_file)

  # TODO: return movie info hash
  {
    title: doc.search('h1').text,
    year: doc.search('.sc-d8941411-2').search('li')[0].text.to_i,
    storyline: doc.search('.sc-2d37a7c7-0.caYjFF').text
  }
end
