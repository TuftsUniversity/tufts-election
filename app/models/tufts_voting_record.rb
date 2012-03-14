class TuftsVotingRecord < ActiveFedora::Base
  has_metadata :name => "RECORD-XML", :type => Datastreams::ElectionRecord
  has_metadata :name => "DCA-META", :type => Datastreams::TuftsDcaMeta
  
  def to_solr(solr_doc=Hash.new)
    super
    solr_doc["title_display"] = solr_doc["title_t"].first
    solr_doc
  end
end
