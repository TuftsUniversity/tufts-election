source 'https://rubygems.org'

gem 'rails', '3.2.2'

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
  gem 'compass-rails', '~> 1.0.0'
  gem 'compass-susy-plugin', '~> 0.9.0'

end

gem 'jquery-rails'

gem "blacklight_range_limit"
gem 'blacklight'
gem 'devise'
gem 'jettywrapper'
#gem 'active-fedora', '4.0.0.rc16'
gem 'active-fedora', :git => 'git://github.com/mediashelf/active_fedora.git'
gem 'solrizer-fedora', :git => 'git://github.com/projecthydra/solrizer-fedora.git', :ref=>'7ede63d' #need to release '2.0.0.rc3'

group :test, :development do
  gem 'rspec-rails'
  # To use debugger
  # gem 'ruby-debug19', :require => 'ruby-debug'
  platform :ruby do
    # Use unicorn as the app server
    gem 'unicorn'
  end
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'


# Deploy with Capistrano
# gem 'capistrano'
