require 'bundler'
Bundler.require

#$:.unshift File.expand_path("")
require_relative 'lib/app/scrapper.rb'


@Scrap = Scrapping.new.perform

