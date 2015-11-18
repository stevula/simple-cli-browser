require 'net/http'
require 'uri'
require 'nokogiri'

class Page
  def initialize(url)
    @url = url
    parse
  end

  def fetch!
    { title: get_title,
      content_length: get_content_length,
      links: get_links }
  end

  private

  def parse
    @parsed_page = PageParser.parse(@url)
  end

  def get_title
    @parsed_page.css('title').children.text
  end

  def get_content_length
    content = @parsed_page.css('p').text
    content.length
  end

  def get_links
    links = @parsed_page.css('a').map {|a| a["href"]}

    # remove internal links
    links.delete_if {|link| link[0..3] != "http"}
  end
end

class PageParser
  def self.parse(url)
    page = URI.parse(url)
    html = Net::HTTP.get(page)
    Nokogiri.parse(html)
  end
end

class Viewer
  def initialize(page_obj)
    @page_attributes = page_obj.fetch!
    display
  end

  def display
    puts "Fetching..."
    puts "Title: #{@page_attributes[:title]}"
    puts "Content length: #{@page_attributes[:content_length]} characters"
    puts "Links:"
    @page_attributes[:links].each do |url|
      puts "  #{url}"
    end
  end
end
