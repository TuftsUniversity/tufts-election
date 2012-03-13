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

