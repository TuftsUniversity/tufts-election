# Class & OM Terminology for working with Tufts Election Record RECORD-XML datastreams
# schemaLocation="http://dca.tufts.edu/aas http://dca.tufts.edu/schema/aas/electionRecord.xsd"
module Datastreams
  class ElectionRecord < ActiveFedora::OmDatastream
    set_terminology do |t|
      t.root(:path=>"election_record",
        :xmlns=>"http://dca.tufts.edu/aas",
        # "xmlns:aas"="http://dca.tufts.edu/aas",
         "xsi:schemaLocation"=>"http://dca.tufts.edu/aas http://dca.tufts.edu/schema/aas/electionRecord.xsd",
         :schema=>"http://ddex.net/xml/2010/ern-main/32/ern-main.xsd")
      #In the latest version of AF/BL date indexes differently then it used to, whereas
      #in the past 2011-01 would index as "2011" it now indexes the full string, or
      #it at least appears that way.
      t.date(:path=>{:attribute=>"date"})
      t.iteration(:path=>{:attribute=>"iteration"}, :index_as=>[:stored_searchable])
      t.label_(:path=>{:attribute=>"label"}, :index_as=>[:stored_searchable])
      t.election_id(:path=>{:attribute=>"election_id"}, :index_as=>[:stored_searchable])
      t.handle(:path=>{:attribute=>"handle"}, :index_as=>[:stored_searchable])
      t.election_record {
        t.election_type(:path=>{:attribute=>"type"}, :index_as=>[:facetable,:stored_searchable])
      }
      t.office {
        t.name(:path=>{:attribute=>"name"})
        t.office_id(:path=>{:attribute=>"office_id"})
        t.scope_(:path=>{:attribute=>"scope"}, :index_as=>[:stored_searchable])
        t.role {
          t.title(:path=>{:attribute=>"title"}, :index_as=>[:facetable,:stored_searchable])
          t.scope_(:path=>{:attribute=>"scope"}, :index_as=>[:stored_searchable])
          t.ballot {
            t.candidate {
              t.name(:path=>{:attribute=>"name"}, :index_as=>[:facetable])
              t.candidate_id(:path=>{:attribute=>"name_id"}, :index_as=>[:facetable])
              t.affiliation(:path=>{:attribute=>"affiliation"}, :index_as=>[:facetable])
            }
            t.elector {
              t.name(:path=>{:attribute=>"name"}, :index_as=>[:facetable, :stored_searchable])
              t.elector_id(:path=>{:attribute=>"name_id"}, :index_as=>[:facetable])
              t.affiliation(:path=>{:attribute=>"affiliation"}, :index_as=>[:facetable])
            }
          }
        }
      }
      
      t.state(:path=>"admin_unit") {
        t.name(:path=>{:attribute=>"name"}, :index_as=>[:facetable,:stored_searchable])
        t.county(:path=>"sub_unit", :attributes=>{:type=>"County"}) {
          t.name(:path=>{:attribute=>"name"}, :index_as=>[:facetable,:stored_searchable])
        }
      }
      t.citation(:path=>"reference", :attributes=>{:type=>"citation"}, :index_as=>[:stored_searchable])
      t.page_image(:path=>"reference", :attributes=>{:type=>"page_image"}, :index_as=>[:facetable,:stored_searchable]) {
        t.urn(:path=>{:attribute=>"urn"}, :index_as=>[:facetable,:stored_searchable])
      }
      
      t.election_type(:proxy=>[:election_record, :election_type], :index_as=>[:facetable,:stored_searchable])
      t.candidate_name(:proxy=>[:office, :role, :ballot, :candidate, :name], :index_as=>[:facetable,:stored_searchable])
      t.candidate_id(:proxy=>[:office, :role, :ballot, :candidate, :candidate_id], :index_as=>[:facetable,:stored_searchable])
      t.candidate_affiliation(:proxy=>[:office, :role, :ballot, :candidate, :affiliation])
      t.elector_name(:proxy=>[:office, :role, :ballot, :elector, :name])
      t.elector_id(:proxy=>[:office, :role, :ballot, :elector, :elector_id])
      t.elector_affiliation(:proxy=>[:office, :role, :ballot, :elector, :affiliation])
      t.jurisdiction(:proxy=>[:office, :role, :scope], :index_as=>[:facetable])

    end
    
    def ElectionRecord.xml_template
    end
    
    def to_solr(solr_doc=Hash.new)
      super

      solr_doc["format_tesim"] = "Election Record"
      solr_doc["format_ssim"] = "Election Record"
      solr_doc["date_isi"] = self.date.to_a.map(&:to_i).first
      solr_doc["date_sim"] = self.date.first[0..3] unless self.date.first.nil?
      solr_doc["election_id_ssim"] = self.election_id.to_a
      solr_doc["handle_ssi"] = self.handle.to_a
      solr_doc["candidate_id_ssim"] = self.candidate_id.to_a
      solr_doc["page_image_urn_ssim"] = self.page_image.urn
      solr_doc["jurisdiction_tesim"] = self.jurisdiction.to_a
      solr_doc["jurisdiction_ssim"] = self.jurisdiction.to_a
      solr_doc["office_id_ssim"] = self.office.office_id.to_a
      solr_doc["office_name_sim"] = [$offices[solr_doc["office_id_ssim"].first.to_s]]
      solr_doc["office_name_tesim"] = [$offices[solr_doc["office_id_ssim"].first.to_s]]
      solr_doc
    end
  end
end
