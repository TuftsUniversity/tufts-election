source 'https://rubygems.org'

ruby '2.3.3'
gem 'rails', '4.2'
#ruby-gemset=tufts-election

platforms :ruby do
  gem 'sqlite3'
end

platforms :jruby do
  gem 'jruby-openssl'
  gem 'activerecord-jdbcsqlite3-adapter'
end

# Gems used only for assets and not required
# in production environments by default.
gem 'coffee-rails'
gem 'uglifier'
gem 'therubyracer'
gem 'sass-rails'
gem 'bootstrap-sass'

gem 'jquery-rails'
gem 'rdf'
gem 'blacklight_range_limit'
gem 'blacklight'
gem 'om', '~> 3.0.4'
gem 'devise'
gem 'active-fedora', '~> 6.7.7'
#gem 'solrizer','3.1.1'
gem 'google-analytics-rails'

group :development, :test do
  gem 'jettywrapper', '1.8.3'
  gem 'solr_wrapper', '>= 0.3'
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'codesake-dawn', :require=>false
end

gem 'rsolr', '~> 1.0'

