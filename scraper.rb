require 'anemone'
require 'watir-webdriver'
#require 'net/http'
#require 'uri'
#require 'open_uri_redirections'
#require 'messie'

# @profile=Selenium::WebDriver::Firefox::Profile.from_name "default"
# @profile.assume_untrusted_certificate_issuer=false
# @profile.secure_ssl = true
@browser = Watir::Browser.new :firefox

base_url = "http://thekingdomofgodisin.me"
puts 'Crawling site'
Anemone.crawl(base_url) do |a|
  URLS = []
  a.on_every_page do |p|
    if p.html?
      URLS << p.url.to_s

      p URLS
    end
  end
end
randomNum = rand(1000..6000)
filenameOut = "web_scraper/scraper_fails_#{randomNum}_.txt"
File.new("#{filenameOut}", "w")
URLS.each do |u|
  @browser.goto(u)
  if @browser.text.include? "404"
    p u + " FAILED: page is broken"
    begin
      file = File.open("#{filenameOut}", "a")
      file.write("#{u} FAILED and is a broken page... \n")
    rescue IOError => e
      p "FAILED TO WRITE"
    ensure
      file.close unless file == nil
    end
  else

  end
  #More Assertions on template:
  @browser.image(:src, "styles/images/eo_logo.gif").exists?     #each page has the logo
  @browser.image(:src, "http://s7.addthis.com/static/btn/v2/lg-share-en.gif").exists?    #each page has the social share icon
  @browser.div(:id => "link_to_title").exists?      #each page has the div field for linking to the page
end
@browser.close