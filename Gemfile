# frozen_string_literal: true
source 'https://rubygems.org'

ruby '3.2.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# changed rails version
# do we want 6.1 or 7.0

gem 'rails', '7.0.2'

gem 'jquery-rails'
gem 'sass-rails'
gem 'uglifier'

# changed blacklight version
gem 'blacklight', '7.24.0'
gem 'blacklight_range_limit'

# removed pinned verision of '~> 0.4.10'
gem 'mysql2'
gem 'okcomputer'
# gem 'rsolr', '>= 1.0'

gem 'qa'
gem 'riiif'

# Matching MIRA's versions
# change active-fedora version
gem 'active-fedora', '14.0.0'
gem 'active_fedora-noid'

# Do we need theses?
# gem 'view_component', '3.4.0'
gem 'thin'
gem 'puma'
# gem 'reel'
gem 'http'
gem 'webrick'

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
gem "twitter-typeahead-rails", "0.11.1.pre.corejavascript"
gem "sassc-rails", "~> 2.1"
gem "jquery-rails"
