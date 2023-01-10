require 'tufts/solr_fixture_loader'

if(Rails.env == "test")
  SolrWrapper.default_instance_options = {
    verbose: true,
    port: 8985,
    version: '6.3.0',
    instance_dir: 'solr/install'
  }
  require 'solr_wrapper/rake_task'
end


Rake::Task[:default].prerequisites.clear
task :default => 'tufts:ci'

# Usually these tasks are provided by hydra-head, but we're only using blacklight.
namespace :tufts do
  desc "Execute Continuous Integration build (docs, tests with coverage)"
  task :ci => :environment do
    SolrWrapper.wrap do |solr|
      solr.with_collection(dir: Rails.root.join('solr/conf/'), name: 'hydra-test') do
        Rake::Task['tufts:index_fixtures'].invoke
        Rake::Task['spec'].invoke
      end
    end
  end

  desc "index elections fixtures"
  task :index_fixtures => :environment do
    Tufts::SolrFixtureLoader.new.load_all_fixtures
  end
end
