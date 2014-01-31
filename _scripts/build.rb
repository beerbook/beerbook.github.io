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



####################################
# 1) generate multi-page version

def build_book

### generate table of contents (toc)

toc_text = <<EOS
---
layout: default
title: Contents
---

EOS

toc_text += render_toc()

File.open( 'index.md', 'w+') do |file|
  file.write toc_text
end


### generate pages for countries

country_count=0
# Country.where( "key in ('at','mx','hr', 'de', 'be', 'nl', 'cz')" ).each do |country|
Country.all.each do |country|
  beers_count     = country.beers.count
  breweries_count = country.breweries.count
  next if beers_count == 0 && breweries_count == 0
  
  country_count += 1
  puts "build country page #{country.key}..."
  country_text = <<EOS
---
layout: default
title: <%= country.title %> (<%= country.code %>)
---

EOS
  
  country_text += render_country( country )
  File.open( "#{country.key}.md", 'w+') do |file|
    file.write country_text
  end
 
  ## break if country_count == 3    # note: for testing only build three country pages
end

end # method build_book


##########################################
# 2) generate all-in-one-page version

def build_book_all_in_one

book_text = <<EOS
---
layout: default
title: Contents
---

EOS

book_text += render_toc( inline: true )


### generate pages for countries
# note: use same order as table of contents

country_count=0

Continent.all.each do |continent|
  continent.countries.order(:title).each do |country|

    beers_count     = country.beers.count
    breweries_count = country.breweries.count
    next if beers_count == 0 && breweries_count == 0
    
    country_count += 1
    puts "build country page #{country.key}..."
    country_text = render_country( country )

    book_text += <<EOS

---------------------------------------

EOS

    book_text += country_text
  end
end


File.open( 'book.md', 'w+') do |file|
  file.write book_text
end

end # method build_book_all_in_one


build_book_all_in_one()


puts 'Done. Bye.'
