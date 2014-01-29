

## Countries

{% Continent.all.each_with_index do |continent,i|  %}
  {% if i > 0 %}
   •
  {% end %}
  {{ continent.title }}
{% end %}



{% Continent.all.each do |continent| %}

### {{ continent.title }}

{% continent.countries.order(:title).each do |country| %}

{{ country.title }} -  xx beers, xx breweries <br>

{% end %}


{% end %}<!-- each continent-->
