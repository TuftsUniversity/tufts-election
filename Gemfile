source 'https://rubygems.org'

ruby '2.1.1'
#ruby-gemset=tufts-election
gem 'rails', '3.2.16'

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
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'bootstrap-sass'
end

gem 'jquery-rails'
gem 'rdf'
gem "blacklight_range_limit"
gem 'blacklight'
gem 'om', '~> 3.0.4'
gem 'devise'
gem 'active-fedora', '~> 6.7.7'
gem 'solrizer','3.1.1'
gem 'google-analytics-rails'
gem 'jettywrapper', '1.5.0'

group :test, :development do
  gem 'rspec-rails'
  # To use debugger
  # gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'codesake-dawn', :require=>false
  platform :ruby do
    # Use unicorn as the app server
    gem 'unicorn'
  end
end