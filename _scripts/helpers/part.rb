# encoding: utf-8

##########################
# part helpers


def continents_navbar    # use render? or just call method/helper continent_navbar ??
  buf = ''
  Continent.all.each_with_index do |continent,i|
    buf << ' • ' if i > 0
    buf << link_to( continent.title, "##{urlify(continent.title)}" )
  end
  buf
end

def regions_navbar_for_country( country )
  buf = ''
  region_count = 0
  country.regions.each do |region|
    buf << ' • '  if region_count > 0
    buf << link_to( region.title, "##{region.key}" )
    buf << " (#{region.breweries.count})"
    region_count += 1
  end

  # check for uncategorized breweries (no region)
  uncategorized_breweries_count = country.breweries.where( 'region_id is null' ).count
  if uncategorized_breweries_count > 0
    buf << ' • '  if region_count > 0
    buf << '** Uncategorized **'
    buf << " (#{uncategorized_breweries_count})"
  end

  buf
end



def cities_navbar_for_region( region )
  buf = ''
  city_count=0
  region.cities.order(:title).each do |city|
    city_breweries_count = city.breweries.count
    if city_breweries_count > 0
      buf << ' • '  if city_count > 0
      buf << link_to( city.title, "##{city.key}" )
      buf << " (#{city_breweries_count})"  if city_breweries_count > 1
      city_count += 1
    end
  end

  # check for uncategorized breweries (no city)
  uncategorized_breweries_count = region.breweries.where( 'city_id is null' ).count
  if uncategorized_breweries_count > 0
    buf << ' • '  if city_count > 0
    buf << '** Uncategorized **'
    buf << " (#{uncategorized_breweries_count})"
  end

  buf
end



#####
# todo: find a better name for ender_toc_countries ??

def render_toc_countries( countries )
  buf = ''
  countries.each do |country|
  
    #<!-- fix: add to models -> countries_w_breweries_or_beers ?? -->
    # <!-- todo: use helper e.g. has_beers_or_breweries? or similar  ?? -->
    beers_count     = country.beers.count
    breweries_count = country.breweries.count
    
    if beers_count > 0 || breweries_count > 0
      buf << link_to_country( country )
      buf << " (#{country.code})"
      buf << " - "
      buf << "#{beers_count} Beers, "
      buf << "#{breweries_count} Breweries <br>"
      buf << "\n"
    end
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
    buf << ' • ' if i > 0
    buf << render_beer( beer )
  end
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

