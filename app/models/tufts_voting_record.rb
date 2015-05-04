class TuftsVotingRecord < ActiveFedora::Base
  has_metadata :name => "RECORD-XML", :type => Datastreams::ElectionRecord
  has_metadata :name => "DCA-META", :type => Datastreams::TuftsDcaMeta
  
  def to_solr(solr_doc=Hash.new,opt={})
    super
    solr_doc["format_ssim"] = solr_doc["format_tesim"]
    solr_doc["title_tesi"] = solr_doc["title_ssi"] = solr_doc["title_tesim"].first
    solr_doc["party_affiliation_sim"] = datastreams["RECORD-XML"].office.role.ballot.candidate.affiliation.to_a + datastreams["RECORD-XML"].office.role.ballot.elector.affiliation.to_a
    affiliate_ids = datastreams["RECORD-XML"].office.role.ballot.candidate.affiliation_id.to_a + datastreams["RECORD-XML"].office.role.ballot.elector.affiliation_id.to_a
    solr_doc["party_affiliation_id_ssim"] =  affiliate_ids - ['null']#if affiliate_ids - ['null'] == []


    solr_doc["voting_record_xml_tesi"] = datastreams["RECORD-XML"].to_xml
    all_text_values = []
    solr_doc.each do |key,value|
      unless ['voting_record_xml_tesi','object_profile_ssm'].include? key
        all_text_values << value
      end
    end

    solr_doc["all_text_timv"] = all_text_values.flatten
    #Add all searchable fields to the all_text_timv field

    solr_doc
  end
end
