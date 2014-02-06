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
require_relative 'helpers/misc'
require_relative 'helpers/beer'
require_relative 'helpers/brewery'
require_relative 'helpers/city'



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
Brewery   = BeerDb::Model::Brewery
Brand     = BeerDb::Model::Brand
Beer      = BeerDb::Model::Beer



####################################
# 1) generate multi-page version

def country_to_md_path( country )

  country_title = country.title.downcase
  country_title = country_title.gsub( /\[[^\]]+\]/, '' ) ## e.g. remove [Mexico] etc.
  country_title = country_title.gsub( 'é', 'e' )  ## todo/fix: use a generic version for accents
  country_title = country_title.strip
  country_title = country_title.gsub(' ', '-')
  country_title = country_title.gsub('-and-', '-n-')

  country_path = ""
  country_path << country.key
  country_path << '-'
  country_path << country_title

  ### quick hack: patch Asia & Australia to => Asia
  # fix: do NOT use sport.db.admin e.g. FIFA continents for beerdb
  if country.key == 'au'
    path = "pacific/#{country_path}.md"
  elsif country.key == 'de'
    # use deutschland NOT germany (same as domain country code)
    path = "europe/de-deutschland.md"  # deutsch/german (de)
  elsif country.key == 'es'
    # use espana NOT spain (same as domain country code)
    path = "europe/es-espana.md"   # spanish/espanol (es)
  elsif country.key == 'ch'
    # use confoederatio helvetica NOT switzerland (same as domain country code)
    path = "europe/ch-confoederatio-helvetica.md" # latin
  elsif country.continent.title == 'Asia & Australia'
    path = "asia/#{country_path}.md"
  else
    path = "#{country.continent.title.downcase.gsub(' ', '-')}/#{country_path}.md"
  end

  path
end


### generate what's news in 2014

years = [2014,2013,2012,2011,2010]
years.each do |year|
  File.open( "#{year}.md", 'w+') do |file|
    file.write render_whats_news_in_year( year, frontmatter: <<EOS )
---
layout: default
title: What's News in #{year}?
---

EOS
  end
end



def build_book

### generate breweries index

File.open( 'breweries.md', 'w+') do |file|
  file.write render_idx_breweries( frontmatter: <<EOS )
---
layout: default
title: Breweries Index
---

EOS
end


### generate beers index

File.open( 'beers.md', 'w+') do |file|
  file.write render_idx_beers( frontmatter: <<EOS )
---
layout: default
title: Beers Index
---

EOS
end


### generate brands index

File.open( 'brands.md', 'w+') do |file|
  file.write render_idx_brands( frontmatter: <<EOS )
---
layout: default
title: Brands Index
---

EOS
end


### generate table of contents (toc)

File.open( 'index.md', 'w+') do |file|
  file.write render_toc( frontmatter: <<EOS )
---
layout: default
title: Contents
---

EOS
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
layout:    default
title:     #{country.title} (#{country.code})
permalink: /#{country.key}.html
---

EOS

  country_text += render_country( country )

  path = country_to_md_path( country )
  puts "path=#{path}"
  File.open( path, 'w+') do |file|
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


build_book()
# build_book_all_in_one()


puts 'Done. Bye.'
