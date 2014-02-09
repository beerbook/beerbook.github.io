## {{ country.title }}   ++
   ({{ country.code }})  ++
   -                     ++
   {{ country.beers.count }} Beers, ++
   {{ country.breweries.count }} Breweries
   {: #{{ country.key }} }

 .. <!-- add intra-page links for regions here -->
 <!-- change to navbar_regions_for_country ?? -->
 {{ regions_navbar_for_country( country ) }}

 .. <!-- list beers w/o (missing) breweries -->
 .. <!-- todo/fix: change name to uncategorized_beers -->
{% beers_missing_breweries = country.beers.where( 'brewery_id is null' )
   if beers_missing_breweries.count > 0
 %}

### Uncategorized Beers

  {{ render_beers( beers_missing_breweries ) }}
{% end %}

  .. <!-- list breweries w/o (missing) region -->
  .. <!-- todo/fix: change name to uncategorized_breweries -->
{% breweries_missing_regions = country.breweries.where( 'region_id is null' )
   if breweries_missing_regions.count > 0
 %}

### Uncategorized _({{ breweries_missing_regions.count }})_{:.count}

  {{ render_breweries( breweries_missing_regions ) }}
{% end %}


  .. <!-- list regions w/ breweries -->
{% country.regions.each do |region| %}

### {{ region.title_w_synonyms }}  ++
    _({{ region.breweries.count }})_{:.count}
{: #{{ country.key }}-{{ region.key }} }

 .. <!-- add intra-page cities for regions links here -->
 <!-- change to navbar_cities_for_region( region ) ??? -->
 {{ cities_navbar_for_region( region ) }}

 {{ columns_begin }}
 {{ render_cities( region.cities.order(:title) ) }}
 {{ columns_end }}

.. <!-- list uncategorized breweries e.g. w/o (missing) city -->
{% uncategorized_breweries = region.breweries.where( 'city_id is null' )
   if uncategorized_breweries.count > 0
 %}

.. <!-- fix: use count helper -->
##### Uncategorized _({{ uncategorized_breweries.count }})_{:.count}

  {{ render_breweries( uncategorized_breweries ) }}
{% end %}


{% end %} <!-- each region -->
