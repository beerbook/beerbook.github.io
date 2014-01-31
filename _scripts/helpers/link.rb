###############################
# link helpers


def link_to_country( country )
  link_to country.title, "#{country.key}.html"
end

