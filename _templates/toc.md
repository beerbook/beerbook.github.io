# The Free World Beer Book


## Table of Contents

[What's News?](#news) • [World Beer Tour](#tour) • [A-Z Breweries, Brands, Beers](#az)


### What's News?
{: #news}

..   <!-- add brewery count ?? -->
[What's News in 2014?](2014.html)  <br>
[What's News in 2013?](2013.html)  <br>
[What's News in 2012?](2012.html)  <br>
[What's News in 2011?](2011.html)  <br>
[What's News in 2010?](2010.html)  <br>



### World Beer Tour
{: #tour}

{{ continents_navbar }}


{% Continent.all.each do |continent| %}


#### {{ continent.title }}
{: #{{ urlify( continent.title ) }} }

  {{ columns_begin }}
  {{ render_toc_countries( continent.countries.order(:title), opts ) }}
  {{ columns_end }}

{% end %}<!-- each continent -->


### A-Z Breweries, Brands, Beers
{: #az}

<!-- fix: for all-in-one page version use/check opts :inline -->
[Breweries A-Z Index](breweries.html) _({{Brewery.count}})_{: .count} <br>
[Brands A-Z Index](brands.html) _({{Brand.count}})_{: .count} <br>
[Beers A-Z Index](beers.html) _({{Beer.count}})_{: .count}  <br>

