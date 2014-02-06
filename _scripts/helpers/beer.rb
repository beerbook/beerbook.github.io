# encoding: utf-8


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
