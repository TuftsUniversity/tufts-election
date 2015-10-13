Rake::Task[:default].prerequisites.clear
task :default => 'tufts:ci'

desc "Index all fixtures"
task :index => 'index:all'

namespace :index do
  desc 'Index fixture objects in the repository.'
  task :all => [:elections]

  desc "index elections fixtures"
  task :elections => :environment do
    e = TuftsVotingRecord.new(:pid=>'tufts:1')
    e.datastreams['RECORD-XML'].content = File.new(File.join(File.dirname(__FILE__), '../../spec/fixtures', "election_records/us_potus_1792_RECORD-XML.xml") ).read
    e.datastreams['DCA-META'].content = File.new(File.join(File.dirname(__FILE__), '../../spec/fixtures', "election_records/us_potus_1792_DCA-META.xml") ).read
    e.save()
    puts "Created tufts:1"
    e = TuftsVotingRecord.new(:pid=>'tufts:2')
    e.datastreams['RECORD-XML'].content =  File.new(File.join(File.dirname(__FILE__), '../../spec/fixtures', "election_records/al_staterepresentative_madisoncounty_1820_RECORD-XML.xml") ).read
    e.datastreams['DCA-META'].content = File.new(File.join(File.dirname(__FILE__), '../../spec/fixtures', "election_records/al_staterepresentative_madisoncounty_1820_DCA-META.xml") ).read
    e.save()
    puts "Created tufts:2"
    
    Dir.glob("spec/fixtures/election_records/*.foxml.xml").each do |fixture_path|
      pid = File.basename(fixture_path, ".foxml.xml").gsub("_",":")
      begin
        foo = ActiveFedora::FixtureLoader.new('spec/fixtures/election_records').reload(pid)
        puts "Updated #{pid}"
      rescue Errno::ECONNREFUSED => e
        puts "Can't connect to Fedora! Are you sure jetty is running?"
      rescue Exception => e
        puts("Received a Fedora error while loading #{pid}\n#{e}")
        logger.error("Received a Fedora error while loading #{pid}\n#{e}")
      end
    end
    
  end

end

# Usually these tasks are provided by hydra-head, but we're only using blacklight.
namespace :tufts do
  desc "Execute Continuous Integration build (docs, tests with coverage)"
  task :ci => :environment do
    require 'jettywrapper'
    Jettywrapper.unzip
    Rake::Task["tufts:jetty:config"].invoke
    jetty_params = Jettywrapper.load_config #.merge({:jetty_home => File.expand_path(File.join(Rails.root, 'jetty'))})

    error = nil
    error = Jettywrapper.wrap(jetty_params) do
      sleep(90)
      Rake::Task["index"].invoke
#      Rake::Task['ci:setup:rspec'].invoke
      Rake::Task["db:migrate"].invoke
      Rake::Task['spec'].invoke
    end
    raise "test failures: #{error}" if error
  end

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
