source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.1.4'

gem 'uglifier'
gem 'sass-rails'
gem 'jquery-rails'

gem 'blacklight'
gem 'blacklight_range_limit'

gem 'mysql2', '~> 0.4.10'
gem 'rsolr', '~> 1.0'

gem 'therubyracer', :platforms => :ruby 

gem 'qa'
# Matching MIRA's versions
gem 'active-fedora', '~> 11.5'
gem 'active_fedora-noid', '~> 2.2'

group :development do
  gem 'sqlite3'
  gem 'byebug'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'rspec-its'
end

group :test do
  gem 'solr_wrapper', '>= 0.3'
end

