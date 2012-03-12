desc "Index all fixtures"
task :index => 'index:all'

namespace :index do
  desc 'Index fixture objects in the repository.'
  task :all => [:elections]

  desc "index elections fixtures"
  task :elections => :environment do
    # buff = DTU::ShardedIndexer.new
    # Nokogiri::XML(File.open("spec/fixtures/records.txt")).root.xpath('/*/sf:art', {'sf'=>'http://schema.cvt.dk/art_oai_sf/2009'}).each do |l|
    #   buff.add(DTU::ArticleEncoder.solrize('article_fixture', l.to_xml))
    # end
    # Nokogiri::XML(File.open("spec/fixtures/article_with_links_and_recommendations.xml")).root.xpath('//sf:art', {'sf'=>'http://schema.cvt.dk/art_oai_sf/2009'}).each do |l|
    #   buff.add(DTU::ArticleEncoder.solrize('article_fixture', l.to_xml))
    # end
    # buff.flush
    # Blacklight.solr.commit
  end

end

