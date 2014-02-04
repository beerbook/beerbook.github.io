
## How to build the "The Free World Beer Book"


Step 1) Build a copy of the beer.db from the plain text datasets.
See the [build scripts repo](https://github.com/openbeer/build).


Step 2) Build the markdown (.md) sources for the static site builder (Jekyll). Issue:

    $ ruby _scripts/build.rb


Step 3) Build the hypertext pages (.html) using the static site builder (Jekyll). Issue:

    $ jekyll build


Step 4) Build the PDF book from the all-in-one page (that is, book.html) using a HTML to PDF tool (e.g. wkhtmltopdf). Issue:

    $ wkhtmltopdf --outline book.html book.pdf



That is. Congratulations. Cheers! Prost! Salud! Kampai!



## Questions? Comments?

Send them along to the
[Open Beer & Brewery Database Forum/Mailing List](http://groups.google.com/group/beerdb).
Thanks!
