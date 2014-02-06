###############################
# link helpers


def link_to_country( country, opts={} )
  if opts[:inline].nil?
    # multi-page version
    link_to "#{country.title} (#{country.code})", "#{country.key}.html"
  else
    # all-in-one page version
    link_to "#{country.title} (#{country.code})", "##{country.key}"
  end
end


def link_to_brewery( brewery, opts={} )
  country = brewery.country
  if opts[:inline].nil?
    # multi-page version
    link_to "#{brewery.title}", "#{country.key}.html##{brewery.key}"
  else
    # all-in-one page version
    link_to "#{brewery.title}", "##{brewery.key}"
  end
end

