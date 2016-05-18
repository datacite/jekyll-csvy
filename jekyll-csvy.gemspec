# -*- encoding: utf-8 -*-
require File.expand_path("../lib/jekyll-csvy/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'jekyll-csvy'
  s.version     = JekyllCsvy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Martin Fenner"]
  s.email       = 'mfenner@datacite.org'
  s.homepage    = 'https://github.com/datacite/jekyll-csvy'
  s.summary     = 'Jekyll CSVY converter'
  s.description = 'A Jekyll CSVY converter that uses Pandoc grid tables.'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.2'

  s.add_dependency "jekyll", '>= 3.0'
  s.add_dependency "jekyll-pandoc", '~> 2.0', '>= 2.0.0'
  s.add_dependency "pandoc-ruby", '~> 2.0', '>= 2.0.0'
  s.add_development_dependency 'rake', '~> 0'
  s.add_development_dependency "rspec", "~> 3.4"
  s.add_development_dependency "rdiscount", '~> 2.1', '>= 2.1.8'

  s.files       = Dir.glob("lib/**/*.rb")
end
