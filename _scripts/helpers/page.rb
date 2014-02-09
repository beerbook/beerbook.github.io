# encoding: utf-8

##########################
# page helpers


def render_country( country, opts={} )
  tmpl       = File.read_utf8( '_templates/country.md' )
  text = ''
  text << opts[:frontmatter]  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end

def render_toc( opts={} )
  tmpl = File.read_utf8( '_templates/toc.md' )
  text = ''
  text << opts[:frontmatter]  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end

def render_whats_news_in_year( year, opts={} )
  tmpl = File.read_utf8( '_templates/whats-news-in-year.md' )
  text = ''
  text << opts[:frontmatter]  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end


def render_breweries_idx( opts={} )
  tmpl = File.read_utf8( '_templates/breweries-idx.md' )
  text = ''
  text << opts[:frontmatter]  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end

def render_beers_idx( opts={} )
  tmpl = File.read_utf8( '_templates/beers-idx.md' )
  text = ''
  text << opts[:frontmatter]  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end

def render_brands_idx( opts={} )
  tmpl = File.read_utf8( '_templates/brands-idx.md' )
  text = ''
  text << opts[:frontmatter]  if opts[:frontmatter]
  text << render_erb_template( tmpl, binding )
  text
end
