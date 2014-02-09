..
..
**{{ link_to_brewery( brewery, opts ) }}** ++
{{ brewery_stars( brewery ) }} ++
.. <!-- fix: add brewery synonyms if exit -->
{{ brewery_tags( brewery ) }} ++ 
( ++
  {{ brewery.country.title }} ++
  {% if brewery.region_id.present? %} › {{ brewery.region.title }} {% end %} ++
  {% if brewery.city_id.present? %} › {{ brewery.city.title }} {% end %} ++
) ++
_#{{ brewery.key }}_{:.key} ++ 
<br>
