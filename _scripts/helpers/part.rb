# encoding: utf-8

##########################
# part helpers


def render_country( country, opts={} )
  country_tmpl       = File.read_utf8( '_templates/country.md.erb' )
  country_text = render_erb_template( country_tmpl, binding )
end


def render_toc( opts={} )
  toc_tmpl = File.read_utf8( '_templates/toc.md.erb' )
  render_erb_template( toc_tmpl, binding )
end

def render_idx_breweries( opts={} )
  idx_tmpl = File.read_utf8( '_templates/idx-breweries.md.erb' )
  render_erb_template( idx_tmpl, binding )
end





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


def render_cities( cities )
  #### <!-- add/fix: cities_w_breweries collection!!! -->
  buf = ''
  cities.each do |city|
    # note: skip cities without breweries
    buf << render_city( city )   if city.breweries.count > 0
  end
  buf
end


def render_breweries( breweries )
  buf = ''
  breweries.each do |brewery|
    buf << render_brewery( brewery )
  end
  buf
end


def render_beers( beers )
  buf = ''
  beers.each_with_index do |beer,i|
    buf << " • \n" if i > 0
    buf << render_beer( beer )
  end
  buf << "\n"
  buf
end


def render_city( city )
  city_tmpl       = File.read_utf8( '_templates/city.md.erb' )
  render_erb_template( city_tmpl, binding )
end

def render_brewery( brewery )
  brewery_tmpl       = File.read_utf8( '_templates/brewery.md.erb' )
  render_erb_template( brewery_tmpl, binding )  
end

def render_beer( beer )
  beer_tmpl       = File.read_utf8( '_templates/beer.md.erb' )
  render_erb_template( beer_tmpl, binding )
end

