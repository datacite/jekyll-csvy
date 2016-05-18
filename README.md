jekyll-csvy
=============

[![Build Status](https://travis-ci.org/datacite/jekyll-csvy.svg?branch=master)](https://travis-ci.org/datacite/jekyll-csvy)

Jekyll-csvy converts CSV to markdown tables in the `grid_tables` format, which are then converted into HTML tables using [jekyll-pandoc](https://github.com/mfenner/jekyll-pandoc).

To use it with Jekyll, create files with the `csvy` extension that have a YAML header and CSV as body. The CSV should

* have a header row
* use a comma as delimiter

Go to [http://csvy.org/](http://csvy.org/) to learn more about CSVY.

## Requirements

* Jekyll, version `3.0` or higher
* Pandoc, version `1.15` or higher

## Installation

Run `bundle install` after adding the gem to your Jekyll `Gemfile`:

```
gem "jekyll-csvy"
```

If you are not using Bundler, install as gem:

```
[sudo] gem install jekyll-csvy
```

## Configuration

None.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
[MIT License](LICENSE).
