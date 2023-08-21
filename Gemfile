# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.7.5'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.2.8'

gem 'jquery-rails'
gem 'sass-rails'
gem 'uglifier'

gem 'blacklight', '6.24.0'
gem 'blacklight_range_limit'

# removed pinned verision of '~> 0.4.10'
gem 'mysql2'
gem 'okcomputer'
gem 'rsolr', '>= 1.0'

gem 'qa'
gem 'riiif'

# Matching MIRA's versions
gem 'active-fedora', '12.2.4'
gem 'active_fedora-noid'

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

group :test do
  gem 'solr_wrapper', '>= 0.3'
end
