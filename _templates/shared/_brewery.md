..

{{ brewery_stars( brewery ) }} ++
{{ brewery_title( brewery ) }} ++
{% if brewery.founded.present? %} ++
  - {{ brewery.founded }} ++
{% end %} ++
{{ brewery_tags( brewery ) }} ++
_#{{ brewery.key }}_{:.key} ++
<br>
.. <!-- check if activerecord supports address? for present? check - if not add it to model -->
{% if brewery.address.present? %}
  {{ brewery.address }}  <br>
{% end %}
.. <!-- check if activerecord supports web? for present? check - if not add it to model -->
{% if brewery.web.present? %}
  {{ link_to brewery.web, "http://#{brewery.web}" }}  <br><!-- fix: use link_to_brewery_website -->
{% end %}
{: .brewery #{{ brewery.key }} }

.. <!-- check if activerecord supports beers? for assoc count check - if not add it to model -->
{% if brewery.beers.count > 0 %}
  .. <!-- fix: make sure render_beers ends with a newline? why? why not?? -->
  .. <!--  do all render_xxx return a line e.g. ending with newline or just a string (span) without newline??? -->
  {{ render_beers( brewery.beers ) }}
  {: .beers }
{% end %}
