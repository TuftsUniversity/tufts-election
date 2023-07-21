# frozen_string_literal: true
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# gem 'rails', '~> 5.0'

# gem 'jquery-rails'
# gem 'sass-rails'
# gem 'uglifier'

# gem 'blacklight', '~> 6.14'
# temp removal 
#gem 'blacklight_range_limit'

# gem 'mysql2', '~> 0.4.10'
# gem 'okcomputer'
# gem 'rsolr', '~> 1.0'

# gem 'qa'
# gem 'riiif'


# Matching MIRA's versions
# Neither of theses are in mira anymore....
# Dropping these cause ruby 2.6 tests to fail
# gem 'active-fedora', '~> 11.5', '>= 11.5.2'
# gem 'active_fedora-noid', '~> 2.2'

# gem 'nokogiri', '1.10.9'


group :development do
  gem 'byebug'
  gem 'sqlite3'
end

group :development, :test do
  gem 'bixby'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'simplecov-lcov', '~> 0.8.0'
end

group :test do
  gem 'solr_wrapper', '>= 0.3'
end
