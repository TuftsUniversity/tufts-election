require 'tufts/solr_fixture_loader'

Rake::Task[:default].prerequisites.clear

# Usually these tasks are provided by hydra-head, but we're only using blacklight.
namespace :tufts do

  desc "index elections fixtures"
  task :index_fixtures => :environment do
    Tufts::SolrFixtureLoader.new.load_all_fixtures
  end
end
