require 'spec_helper'

describe Datastreams::ElectionRecord do
  
  describe "to_solr" do
    it "should only index the year part of the date" do
        @potus_1792 = Datastreams::ElectionRecord.from_xml( fixture("election_records/us_potus_1792_RECORD-XML.xml") )
        @potus_1792.date = '1820-11'
        @potus_1792.to_solr['date_isi'].should == 1820
        
    end
    describe "state_name_facet" do
      describe "when the admin unit is a State" do
        subject { Datastreams::ElectionRecord.from_xml('<aas:election_record xmlns:aas="http://dca.tufts.edu/aas"> <aas:office><aas:role><aas:admin_unit geog_id="mes" name="Maine" type="State"></aas:admin_unit></aas:role></aas:office></aas:election_record>').to_solr} 
        it "should be the states name" do
          subject["state_name_sim"].should == ['Maine'] 
        end
      end
      describe "when the admin unit is a Territory" do
        subject { Datastreams::ElectionRecord.from_xml('<aas:election_record xmlns:aas="http://dca.tufts.edu/aas"> <aas:office><aas:role><aas:admin_unit geog_id="mes" name="Maine" type="Territory"></aas:admin_unit></aas:role></aas:office></aas:election_record>').to_solr} 
        it "should be the territorys name" do
          subject["state_name_sim"].should == ['Maine'] 
        end
      end
    end
    describe "with some fixtures" do
      before(:each) do
        @potus_1792 = Datastreams::ElectionRecord.from_xml( fixture("election_records/us_potus_1792_RECORD-XML.xml") )
        @madisoncounty_1820 = Datastreams::ElectionRecord.from_xml( fixture("election_records/al_staterepresentative_madisoncounty_1820_RECORD-XML.xml") )
        @potus_solr = @potus_1792.to_solr
        @county_solr = @madisoncounty_1820.to_solr
      end
      it "should set field values" do
        @potus_solr["format_ssim"].should == "Election Record"
        @potus_solr["date_sim"].should == "1792"
        @potus_solr["date_isi"].should == 1792
        @potus_solr["iteration_tesim"].should == ["First Ballot"]
        @potus_solr["label_tesim"].should == ["1792 President of the United States, Electoral College"]
        @potus_solr["election_id_tesim"].should == ["us.potus.1792"]
        @potus_solr["handle_tesim"].should == ["10427/65038"]
        @potus_solr["election_type_tesim"].should == ["Legislative"]
        @potus_solr["election_type_sim"].should == ["Legislative"]
        @potus_solr["jurisdiction_tesim"].should == ["Federal"]
        
        @potus_solr["office_name_tesim"].should == ["President of the United States"]
        @potus_solr["office_name_sim"].should == ["President of the United States"]
        @potus_solr["office_id_ssim"].should == ["ON082"]
        @potus_solr["office_scope_tesim"].should == ["Federal"]
        @potus_solr["office_role_title_tesim"].should == ["President of the United States"]
        @potus_solr["office_role_title_sim"].should == ["President of the United States"]
        @potus_solr["office_role_scope_tesim"].should == ["Federal"]
        @potus_solr["candidate_name_tesim"].should == ["George Washington", "John Adams", "George Clinton", "Thomas Jefferson", "Aaron Burr"]
        @potus_solr["candidate_name_sim"].should == ["George Washington", "John Adams", "George Clinton", "Thomas Jefferson", "Aaron Burr"]
        @potus_solr["candidate_id_tesim"].should == ["WG0011", "AJ0076", "CG0080", "JT0012", "BA0134"]
        
        @county_solr["page_image_urn_ssim"].should == ["tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024", "tufts:central:dca:MS115:MS115.001.DO.11024"]
        @county_solr["citation_tesim"].should == ["Alabama Republican (Huntsville), August 11, 1820. (Phil's typewritten notes.)", "Election Record from Alabama State Archives.", "The Republican (Huntsville). August 11, 1820.", "The Republican (Huntsville). September 1, 1820.", "The Halcyon (Saint Stephens).  August 21, 1820."]
        @county_solr["date_sim"].should == "1820"

        @county_solr["state_name_tesim"].should == ["Alabama"]
        @county_solr["state_name_sim"].should == ["Alabama"]
        @county_solr["state_county_name_tesim"].should == ["Madison"]
        @county_solr["state_county_name_sim"].should == ["Madison"]
        @county_solr["jurisdiction_tesim"].should == ["State"]
        @county_solr["jurisdiction_sim"].should == ["State"]
        
        
        @county_solr["office_name_tesim"].should == ["House of Representatives"]
        @county_solr["office_id_ssim"].should == ["ON064"]
        @county_solr["office_scope_tesim"].should == ["State"]
        @county_solr["office_role_title_tesim"].should == ["State Representative"]
        @county_solr["office_role_scope_tesim"].should == ["County"]      
      end
    end

  end
  
end
