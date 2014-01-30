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



def render_erb_template( tmpl )

# note: erb offers the following trim modes:
#  1) <> omit newline for lines starting with <% and ending in %>
#  2)  >  omit newline for lines ending in %>
#  3)  omit blank lines ending in -%>
  ## run filters
  tmpl = remove_html_comments( tmpl )
  tmpl = remove_blanks( tmpl )
  tmpl = remove_leading_spaces( tmpl )
  tmpl = concat_lines( tmpl )

  text = ERB.new( tmpl, nil, '<>' ).result( binding )

  ### text = cleanup_newlines( text )
  text
end


### markdown helpers

def link_to( title, link )
  "[#{title}](#{link})"
end



### filters
#
#  todo: move to textutils for reuse !!!

def remove_html_comments( text )
  text.gsub( /<!--.+?-->/, '' )
end

def remove_leading_spaces( text )
  # remove leading spaces if less than four !!!
  text.gsub( /^[ \t]+(?![ \t])/, '' )    # use negative regex lookahead e.g. (?!)
end

def remove_blanks( text )
  # remove lines only with  ..
  text.gsub( /^[ \t]*\.{2}[ \t]*\n/, '' )
end

def cleanup_newlines( text )
  # remove all blank lines that go over three
  text.gsub( /\n{4,}/, "\n\n\n" )
end


def concat_lines( text )
  #  lines ending with  ++  will get newlines get removed
  # e.g.
  # >|   hello1 ++
  # >1   hello2
  #  becomes
  # >|   hello1 hello2
  
  #
  # note: do NOT use \s - will include \n (newline) ??
  
  text.gsub( /[ \t]+\+{2}[ \t]*\n[ \t]*/, ' ' )  # note: replace with single space
end



### generate table of contents (toc)

toc_countries_tmpl = File.read_utf8( '_templates/toc_countries.md.erb' )

toc_countries_text = render_erb_template( toc_countries_tmpl )


File.open( 'index.md', 'w+') do |file|
  file.write toc_countries_text
end



puts 'Done. Bye.'




