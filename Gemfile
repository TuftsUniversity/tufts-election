source 'https://rubygems.org'

ruby '2.2.3'
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
group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'therubyracer'
  gem 'sass-rails'
  gem 'bootstrap-sass'
end

gem 'jquery-rails'
gem 'rdf'
gem 'blacklight_range_limit'
gem 'blacklight'
gem 'om', '~> 3.0.4'
gem 'devise'
gem 'active-fedora', '~> 6.7.7'
gem 'solrizer','3.1.1'
gem 'google-analytics-rails'
gem 'jettywrapper'

#group :development do
#  # support for rails_panel chrome extension
#  gem 'meta_request', '0.3.4'
#end

group :test, :development do
  gem 'rspec-rails'
  # To use debugger
  # gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'codesake-dawn', :require=>false
end
