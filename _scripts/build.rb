# encoding: utf-8

# world book build script
#
#  run from book folder e.g. issue:
#   $ ruby _scripts/build.rb


# ruby std libs

require 'erb'

# 3rd party gems

require 'worlddb'   ### NB: for local testing use rake -I ./lib dev:test e.g. do NOT forget to add -I ./lib
require 'beerdb'
require 'logutils/db'


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



### generate table of contents (toc)

toc_countries_tmpl = File.read_utf8( '_templates/toc_countries.md.erb' )

# note: erb offers the following trim modes:
#  1) <> omit newline for lines starting with <% and ending in %>
#  2)  >  omit newline for lines ending in %>
#  3)  omit blank lines ending in -%>

toc_countries_erb  = ERB.new( toc_countries_tmpl, nil, '>' )

File.open( 'index.md', 'w+') do |file|
  file.write toc_countries_erb.result(binding)
end

### todo: use filter to strip leading spaces
### todo: use   ++ at the end of line to strip new line w/ filter !!!
## todo: just use %> trim mode -- only trim blank/stmt lines!!!
### todo: add filter to remove html/xml comments e.g. <!-- -->


puts 'Done. Bye.'




