###############################
# link helpers


def link_to_country( country )
  link_to "#{country.title} (#{country.code})", "#{country.key}.html"
end

