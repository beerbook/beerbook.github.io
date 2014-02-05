# encoding: utf-8

###
## todo: split into city.rb / beer.rb / brewery.rb etc.

def city_breweries_count( city )
  buf = ''
  buf << "_(#{ city.breweries.count })_{:.count}"   if city.breweries.count > 1
  buf
end


### todo:
##  add to textutils ?? why? why not??
def number_with_delimiter( num )
  delimiter = '.'
  num.to_s.reverse.gsub( /(\d{3})(?=\d)/, "\\1#{delimiter}").reverse
end


def city_pop( city )
  buf = ''
  pops = []

  pops << number_with_delimiter( city.pop )           if city.pop.present?
  pops << "(#{number_with_delimiter(city.popm)})"     if city.popm.present?

  buf << " _pop #{pops.join(' ')}_{:.pop}"  if pops.size > 0
  buf
end


def brewery_stars( brewery )
  buf = ''
  ### e.g.
  # grade 1 -> ♣♣♣  (three stars)
  # grade 2 -> ♣♣ (two stars)
  # grade 3 -> ♣ (one star)
  # grade 4 -> no star
  if (4-brewery.grade) > 0
    (4-brewery.grade).times { buf << '♣' }
     buf << ' '
  end
  buf
end


def brewery_title( brewery )  # brewery title plus synonyms if present
  buf = ''
  buf << brewery.title
  if brewery.synonyms.present?
    buf << ' • '
    buf << brewery.synonyms.gsub('|', ' • ')
  end
  ## buf << " ‹#{brewery.grade}›"      ### remove? just for debugging ??
  buf
end


def brewery_tags( brewery, opts={} )
  ### todo: add hl production at the end if present
  
  buf = ''
  if brewery.tags.count > 0
    buf << '_'
    brewery.tags.each_with_index do |tag,i|
      buf << ' '  if i > 0
      buf << "#{tag.title}"
    end
    buf << '_{:.tags}'
  end
  buf
end


def beer_facts( beer )   # rename to facts_for_beer() ???
  buf = ''
  facts = []
  facts << "#{beer.abv}%"  if beer.abv.present?
  facts << "#{beer.og}°"  if beer.og.present?

  buf << "(#{facts.join(', ')})"  if facts.size > 0

  buf
end


def beer_tags( beer, opts={} )   # rename to tags_for_beer or tags_beer ??
  buf = ''
  if beer.tags.count > 0
    buf << '_'
    beer.tags.each_with_index do |tag,i|
      buf << ' '  if i > 0
      buf << "#{tag.title}"
    end
    buf << '_{:.tags}'
  end
  buf
end

