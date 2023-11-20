# frozen_string_literal: true
source 'https://rubygems.org'

ruby '3.2.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '7.0.2'

gem 'jquery-rails'
gem 'sass-rails'
gem 'uglifier'

gem 'blacklight', '7.24.0'
# pinned to not move to version 8, which breaks our custom javascript
gem 'blacklight_range_limit', '7.8.0'

# removed pinned verision of '~> 0.4.10'
gem 'mysql2'
gem 'okcomputer'

gem 'qa'
gem 'riiif'

# Matching MIRA's versions
# change active-fedora version
gem 'active-fedora', '14.0.0'
gem 'active_fedora-noid'

# previously prepackaged gems in ruby 2
gem 'http'
gem 'puma'
gem 'thin'
#gem 'webrick'

group :production do
  gem 'passenger'
end

group :development do
  gem 'byebug'
end

group :development, :test do
  gem 'bixby'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'simplecov-lcov', '~> 0.8.0'
end

group :development, :test do
  gem "solr_wrapper", ">= 0.3"
end
gem "rsolr", ">= 1.0", "< 3"

gem "bootstrap", "~> 4.0"
gem "sassc-rails", "~> 2.1"
gem "twitter-typeahead-rails", "0.11.1.pre.corejavascript"
