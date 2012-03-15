# Class & OM Terminology for working with Tufts Election Record RECORD-XML datastreams
# schemaLocation="http://dca.tufts.edu/aas http://dca.tufts.edu/schema/aas/electionRecord.xsd"
module Datastreams
  class ElectionRecord < ActiveFedora::NokogiriDatastream
    set_terminology do |t|
      t.root(:path=>"election_record",
        :xmlns=>"http://dca.tufts.edu/aas",
        # "xmlns:aas"="http://dca.tufts.edu/aas",
         "xsi:schemaLocation"=>"http://dca.tufts.edu/aas http://dca.tufts.edu/schema/aas/electionRecord.xsd",
         :schema=>"http://ddex.net/xml/2010/ern-main/32/ern-main.xsd")
      t.date(:path=>{:attribute=>"date"})
      t.iteration(:path=>{:attribute=>"iteration"})
      t.label_(:path=>{:attribute=>"label"})
      t.election_id(:path=>{:attribute=>"election_id"})
      t.handle(:path=>{:attribute=>"handle"})
      t.election_record {
        t.election_type(:path=>{:attribute=>"type"}, :index_as=>[:facetable])
      }
      t.office {
        t.name(:path=>{:attribute=>"name"}, :index_as=>[:facetable])
        t.office_id(:path=>{:attribute=>"office_id"})
        t.scope_(:path=>{:attribute=>"scope"})
        t.role {
          t.title(:path=>{:attribute=>"title"}, :index_as=>[:facetable])
          t.scope_(:path=>{:attribute=>"scope"})
          t.ballot {
            t.candidate {
              t.name(:path=>{:attribute=>"name"}, :index_as=>[:facetable])
              t.candidate_id(:path=>{:attribute=>"name_id"}, :index_as=>[:facetable])
              t.affiliation(:path=>{:attribute=>"affiliation"}, :index_as=>[:facetable])
            }
            t.elector {
              t.name(:path=>{:attribute=>"name"}, :index_as=>[:facetable])
              t.elector_id(:path=>{:attribute=>"name_id"}, :index_as=>[:facetable])
              t.affiliation(:path=>{:attribute=>"affiliation"}, :index_as=>[:facetable])
            }
          }
        }
      }
      
      t.admin_unit {
        t.type(:path=>{:attribute=>"type"})
        t.sub_unit {
          t.type(:path=>{:attribute=>"type"})
        }
      }
      t.state(:path=>"admin_unit", :attributes=>{:type=>"State"}) {
        t.name(:path=>{:attribute=>"name"}, :index_as=>[:facetable])
        t.county(:path=>"sub_unit", :attributes=>{:type=>"County"}) {
          t.name(:path=>{:attribute=>"name"}, :index_as=>[:facetable])
        }
      }
      t.citation(:path=>"reference", :attributes=>{:type=>"citation"})
      t.page_image(:path=>"reference", :attributes=>{:type=>"page_image"}) {
        t.urn(:path=>{:attribute=>"urn"})
      }
      
      t.election_type(:proxy=>[:election_record, :election_type])
      t.candidate_name(:proxy=>[:office, :role, :ballot, :candidate, :name])
      t.candidate_id(:proxy=>[:office, :role, :ballot, :candidate, :candidate_id])
      t.candidate_affiliation(:proxy=>[:office, :role, :ballot, :candidate, :affiliation])
      t.elector_name(:proxy=>[:office, :role, :ballot, :elector, :name])
      t.elector_id(:proxy=>[:office, :role, :ballot, :elector, :elector_id])
      t.elector_affiliation(:proxy=>[:office, :role, :ballot, :elector, :affiliation])
      t.jurisdiction(:proxy=>[:admin_unit, :sub_unit, :type])

    end
    
    def ElectionRecord.xml_template
    end
    
    def to_solr(solr_doc=Hash.new)
      super
      solr_doc["format"] = "Election Record"
      solr_doc["date_i"] = self.date.to_a
      solr_doc["election_id_s"] = self.election_id.to_a
      solr_doc["handle_s"] = self.handle.to_a
      solr_doc["office_id_s"] = self.office.office_id.to_a
      solr_doc["candidate_id_s"] = self.candidate_id.to_a
      solr_doc["page_image_urn_s"] = self.page_image.urn
      if self.office.scope.include?("Federal")
        solr_doc["jurisdiction_display"] = ["Federal"]
      else
        solr_doc["jurisdiction_display"] = self.admin_unit.sub_unit.type.to_a
      end
      
      solr_doc
    end
    
  end
end
