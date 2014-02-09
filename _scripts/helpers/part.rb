# encoding: utf-8

##########################
# part helpers


#####
# todo: find a better name for ender_toc_countries ??


def render_toc_countries( countries, opts={} )
  buf = ''
  countries.each do |country|
  
    #<!-- fix: add to models -> countries_w_breweries_or_beers ?? -->
    # <!-- todo: use helper e.g. has_beers_or_breweries? or similar  ?? -->
    beers_count     = country.beers.count
    breweries_count = country.breweries.count
    
    next if beers_count == 0 && breweries_count == 0
    
    buf << link_to_country( country, opts )
    buf << " - "
    buf << "_#{beers_count} Beers, #{breweries_count} Breweries_{:.count}"
    buf << "  <br>"
    buf << "\n"
  end
  buf
end


def render_cities( cities, opts={} )
  #### <!-- add/fix: cities_w_breweries collection!!! -->
  buf = ''
  cities.each do |city|
    # note: skip cities without breweries
    buf << render_city( city, opts )   if city.breweries.count > 0
  end
  buf
end


def render_breweries( breweries, opts={} )
  buf = ''
  breweries.each do |brewery|
    buf << render_brewery( brewery, opts )
  end
  buf
end


def render_beers( beers, opts={} )
  buf = ''
  beers.each_with_index do |beer,i|
    buf << " • \n" if i > 0
    buf << render_beer( beer, opts )
  end
  buf << "\n"
  buf
end


def render_city( city, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_city.md' )
  render_erb_template( tmpl, binding )
end

def render_brewery( brewery, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_brewery.md' )
  render_erb_template( tmpl, binding )  
end

def render_brewery_idx( brewery, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_brewery-idx.md' )
  render_erb_template( tmpl, binding )  
end

def render_beer( beer, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_beer.md' )
  render_erb_template( tmpl, binding )
end

def render_beer_idx( beer, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_beer-idx.md' )
  render_erb_template( tmpl, binding )
end

def render_brand_idx( brand, opts={} )
  tmpl       = File.read_utf8( '_templates/shared/_brand-idx.md' )
  render_erb_template( tmpl, binding )
end
