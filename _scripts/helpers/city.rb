# encoding: utf-8

def city_breweries_count( city )
  buf = ''
  buf << "_(#{ city.breweries.count })_{:.count}"   if city.breweries.count > 1
  buf
end


def city_pop( city )
  buf = ''
  pops = []

  pops << number_with_delimiter( city.pop )           if city.pop.present?
  pops << "(#{number_with_delimiter(city.popm)})"     if city.popm.present?

  buf << " _pop #{pops.join(' ')}_{:.pop}"  if pops.size > 0
  buf
end


