# encoding: utf-8

# world book build script
#
#  run from book folder e.g. issue:
#   $ ruby _scripts/build.rb


# -- ruby std libs

require 'erb'

# -- 3rd party gems

require 'worlddb'   ### NB: for local testing use rake -I ./lib dev:test e.g. do NOT forget to add -I ./lib
require 'beerdb'
require 'logutils/db'

# -- custom code

require_relative 'helpers/link'
require_relative 'helpers/markdown'
require_relative 'helpers/navbar'
require_relative 'helpers/part'


require_relative 'filters'
require_relative 'utils'



puts 'Welcome'



puts "Dir.pwd: #{Dir.pwd}"

# --  db config
BEER_DB_PATH = "../build/build/beer.db"


LogUtils::Logger.root.level = :info

DB_CONFIG = {
  adapter:    'sqlite3',
  database:   BEER_DB_PATH
}

pp DB_CONFIG
ActiveRecord::Base.establish_connection( DB_CONFIG )


WorldDb.tables
BeerDb.tables


### model shortcuts

Continent = WorldDb::Model::Continent
Country   = WorldDb::Model::Country




### generate table of contents (toc)

toc_tmpl = File.read_utf8( '_templates/toc.md.erb' )
country_tmpl       = File.read_utf8( '_templates/country.md.erb' )


toc_text = render_erb_template( toc_tmpl, binding )


File.open( 'index.md', 'w+') do |file|
  file.write toc_text
end


### generate pages for countries

country_count=0
Country.where( "key in ('at','mx','hr', 'de', 'be', 'nl', 'cz')" ).each do |country|
  beers_count     = country.beers.count
  breweries_count = country.breweries.count
  if beers_count > 0 || breweries_count > 0
    country_count += 1
    puts "build country page #{country.key}..."
    country_text = render_erb_template( country_tmpl, binding )
    File.open( "#{country.key}.md", 'w+') do |file|
      file.write country_text
    end
  end
  ## break if country_count == 3    # note: for testing only build three country pages
end


puts 'Done. Bye.'
