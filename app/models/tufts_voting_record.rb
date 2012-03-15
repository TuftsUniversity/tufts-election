class TuftsVotingRecord < ActiveFedora::Base
  has_metadata :name => "RECORD-XML", :type => Datastreams::ElectionRecord
  has_metadata :name => "DCA-META", :type => Datastreams::TuftsDcaMeta
  
  def to_solr(solr_doc=Hash.new)
    super
    solr_doc["title_display"] = solr_doc["title_t"].first
    solr_doc["party_affiliation_facet"] = datastreams["RECORD-XML"].office.role.ballot.candidate.affiliation.to_a + datastreams["RECORD-XML"].office.role.ballot.elector.affiliation.to_a 
    solr_doc
  end
end
