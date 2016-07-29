require 'spec_helper'

describe TuftsVotingRecord do
  describe "an instance" do
    subject { TuftsVotingRecord.new }
    its(:RECORD_XML) { should be_kind_of Datastreams::ElectionRecord}
    its(:DCA_META) { should be_kind_of Datastreams::TuftsDcaMeta}
  end
  describe "to_solr" do
    before do
      @record = TuftsVotingRecord.find("tufts:2")
      @solr_doc = @record.to_solr
    end
    it "should index the correct fields" do
      expect(@solr_doc["voting_record_xml_tesi"]).to eq(@record.datastreams["RECORD-XML"].to_xml)
      expect(@solr_doc["title_tesim"]).to eq(['Alabama 1820 House of Representatives, Madison County'])
      expect(@solr_doc["title_tesi"]).to eq('Alabama 1820 House of Representatives, Madison County')
    end
  end
end
