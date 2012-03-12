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
      t.election_type(:path=>{:attribute=>"type"})
      t.handle(:path=>{:attribute=>"handle"})
      t.office {
        t.name(:path=>{:attribute=>"name"})
        t.office_id(:path=>{:attribute=>"office_id"})
        t.scope_(:path=>{:attribute=>"scope"})
        t.role {
          t.title(:path=>{:attribute=>"title"})
          t.scope_(:path=>{:attribute=>"scope"})
          t.ballot {
            t.candidate {
              t.name
              t.candidate_id
            }
          }
        }
      }
      
      
      t.state(:path=>"admin_unit", :attributes=>{:type=>"State"}) {
        t.name(:path=>{:attribute=>"name"})
        t.county(:path=>"sub_unit", :attributes=>{:type=>"County"}) {
          t.name(:path=>{:attribute=>"name"})
        }
      }
      t.citation(:path=>"reference", :attributes=>{:type=>"citation"})
      t.page_image_urn(:path=>"reference", :attributes=>{:type=>"page_image"})
    end
    
    def ElectionRecord.xml_template
    end
  end
end
