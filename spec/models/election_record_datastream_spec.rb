require 'spec_helper'

describe Datastreams::ElectionRecord do
  
  describe "to_solr" do
    it "should only index the year part of the date" do
        @potus_1792 = Datastreams::ElectionRecord.from_xml( fixture("election_records/us_potus_1792_RECORD-XML.xml") )
        @potus_1792.date = '1820-11'
        @potus_1792.to_solr['date_i'].should == 1820
        
    end
    describe "with some fixtures" do
      before(:each) do
        @potus_1792 = Datastreams::ElectionRecord.from_xml( fixture("election_records/us_potus_1792_RECORD-XML.xml") )
        @madisoncounty_1820 = Datastreams::ElectionRecord.from_xml( fixture("election_records/al_staterepresentative_madisoncounty_1820_RECORD-XML.xml") )
        @potus_solr = @potus_1792.to_solr
        @county_solr = @madisoncounty_1820.to_solr
      end
      it "should set field values" do
        @potus_solr["format"].should == "Election Record"
        @potus_solr["date_t"].should == ["1792"]
        @potus_solr["date_i"].should == 1792
        @potus_solr["iteration_t"].should == ["First Ballot"]
        @potus_solr["label_t"].should == ["1792 President of the United States, Electoral College"]
        @potus_solr["election_id_s"].should == ["us.potus.1792"]
        @potus_solr["handle_s"].should == ["10427/65038"]
        @potus_solr["election_type_t"].should == ["Legislative"]
        @potus_solr["election_type_facet"].should == ["Legislative"]
        @potus_solr["jurisdiction_display"].should == ["Federal"]
        
        @potus_solr["office_name_t"].should == ["President of the United States"]
        @potus_solr["office_name_facet"].should == ["President of the United States"]
        @potus_solr["office_id_s"].should == ["ON069"]
        @potus_solr["office_scope_t"].should == ["Federal"]
        @potus_solr["office_role_title_t"].should == ["President of the United States"]
        @potus_solr["office_role_title_facet"].should == ["President of the United States"]
        @potus_solr["office_role_scope_t"].should == ["Federal"]
        @potus_solr["candidate_name_t"].should == ["George Washington", "John Adams", "George Clinton", "Thomas Jefferson", "Aaron Burr"]
        @potus_solr["candidate_name_facet"].should == ["George Washington", "John Adams", "George Clinton", "Thomas Jefferson", "Aaron Burr"]
        @potus_solr["candidate_id_s"].should == ["WG0011", "AJ0076", "CG0080", "JT0012", "BA0134"]
        
        @county_solr["format"].should == "Election Record"
        @county_solr["page_image_urn_s"].should == ["tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024"]
        @county_solr["citation_t"].should == ["Alabama Republican (Huntsville), August 11, 1820. (Phil's typewritten notes.)", "Election Record from Alabama State Archives.", "The Republican (Huntsville). August 11, 1820.", "The Republican (Huntsville). September 1, 1820.", "The Halcyon (Saint Stephens). August 21, 1820."]
        @county_solr["date_t"].should == ["1820"]

        @county_solr["state_name_t"].should == ["Alabama"]
        @county_solr["state_name_facet"].should == ["Alabama"]
        @county_solr["state_county_name_t"].should == ["Madison"]
        @county_solr["state_county_name_facet"].should == ["Madison"]
        @county_solr["jurisdiction_display"].should == ["County"]
        
        
        @county_solr["office_name_t"].should == ["House of Representatives"]
        @county_solr["office_id_s"].should == ["ON057"]
        @county_solr["office_scope_t"].should == ["State"]
        @county_solr["office_role_title_t"].should == ["State Representative"]
        @county_solr["office_role_scope_t"].should == ["County"]      
      end
    end

  end
  
end
