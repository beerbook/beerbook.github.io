# The Free World Beer Book

- [openbeer.github.io/book](http://openbeer.github.io/book) - HTML page version
- [openbeer.github.io/book/book.html](http://openbeer.github.io/book/book.html) - All-in-one-page HTML version
- [openbeer.github.io/book.pdf](http://openbeer.github.io/book.pdf) - PDF booklet version


Note, all data and scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.



### How to build the book from source


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
