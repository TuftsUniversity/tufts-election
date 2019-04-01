require 'tufts/solr_fixture_loader'

Rake::Task[:default].prerequisites.clear
task :default => 'tufts:ci'

# Usually these tasks are provided by hydra-head, but we're only using blacklight.
namespace :tufts do
  desc "Execute Continuous Integration build (docs, tests with coverage)"
  task :ci => :environment do
    Rake::Task['spec'].invoke
  end

  desc "index elections fixtures"
  task :index_fixtures => :environment do
    Tufts::SolrFixtureLoader.new.load_all_fixtures
  end

  #namespace :jetty do
  #  desc "Copies the default Solr & Fedora configs into the bundled Hydra Testing Server"
  #  task :config do
  #    Rake::Task["tufts:jetty:config_solr"].invoke
  #  end

  #  desc "Copies the contents of solr_conf into the Solr development-core and test-core of Testing Server"
  #  task :config_solr do
  #    FileList['solr_conf/conf/*'].each do |f|  
  #      cp("#{f}", 'jetty/solr/development-core/conf/', :verbose => true)
  #      cp("#{f}", 'jetty/solr/test-core/conf/', :verbose => true)
  #    end
  #  end
  #end
end
