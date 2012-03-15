require 'spec_helper'

describe VotingRecordHelper do
  describe "voting_record_xml_to_table" do
    before {
      @src = File.read(fixture("election_records/al_staterepresentative_madisoncounty_1820_RECORD-XML.xml"))
    }
    subject {
      helper.voting_record_xml_to_table(@src)
    }
    it{should match "^<div id=\"electionTitle\">"}
    it{should match "<img src=\"http://repository01.lib.tufts.edu:8080/fedora/get/tufts:MS115.001.DO.11024/bdef:TuftsImage/getMediumRes\" alt=\"handwritten notes\">"}
  end
end
