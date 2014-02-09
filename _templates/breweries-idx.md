# Breweries A-Z Index _({{ Brewery.count }})_{:.count}

.. <!-- add/fix: add category for starting w/ non-letters e.g. digits -->
.. <!-- todo: add entries for synonims - how?? use see xxx  why?  why not? -->

.. <!-- use helper e.g. navbar_az( topic ) or similar ?? -->
{% ('A'..'Z').each_with_index do |letter,i| %}
  {% if i > 0 then %} • {% end %} {{ letter }}
{% end %}


{% ('A'..'Z').each do |letter| %}

## {{ letter }}

{{ columns_begin }}
{% Brewery.where( "key like '#{letter.downcase}%'").order(:key).each do |brewery| %}
  {{ render_brewery_idx( brewery, opts ) }}
{% end %}
{{ columns_end }}

{% end %}
