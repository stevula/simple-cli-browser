require 'net/http'
require 'nokogiri'

require_relative 'page'

class Browser
  def initialize
    welcome
    run!
  end

  def run!
    get_user_input
    generate_page
    display_page
    run!
  end

  def welcome
    puts "Starting a new session..."
    sleep(2)
  end

  def get_user_input
    puts "Enter web address:"
    @url = gets.chomp
  end

  def generate_page
    @page = Page.new(@url)
  end

  def display_page
    Viewer.new(@page)
    sleep(5)
  end
end

Browser.new.run!
