desc "Index all fixtures"
task :index => 'index:all'

namespace :index do
  desc 'Index fixture objects in the repository.'
  task :all => [:elections]

  desc "index elections fixtures"
  task :elections => :environment do
    e = Election.new(:pid=>'tufts:1')
    e.datastreams['RECORD-XML'].content = File.new(File.join(File.dirname(__FILE__), '../../spec/fixtures', "election_records/us_potus_1792_RECORD-XML.xml") ).read
    e.save()
    e = Election.new(:pid=>'tufts:2')
    e.datastreams['RECORD-XML'].content =  File.new(File.join(File.dirname(__FILE__), '../../spec/fixtures', "election_records/al_staterepresentative_madisoncounty_1820_RECORD-XML.xml") ).read
    e.save()
  end

end

# Usually these tasks are provided by hydra-head, but we're only using blacklight.
namespace :tufts do
  namespace :jetty do
    desc "Copies the default Solr & Fedora configs into the bundled Hydra Testing Server"
    task :config do
      Rake::Task["tufts:jetty:config_solr"].invoke
    end
  
    desc "Copies the contents of solr_conf into the Solr development-core and test-core of Testing Server"
    task :config_solr do
      FileList['solr_conf/conf/*'].each do |f|  
        cp("#{f}", 'jetty/solr/development-core/conf/', :verbose => true)
        cp("#{f}", 'jetty/solr/test-core/conf/', :verbose => true)
      end
    end
  end
end
