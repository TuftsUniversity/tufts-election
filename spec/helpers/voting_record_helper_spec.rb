require 'spec_helper'

describe VotingRecordHelper do
  describe "voting_record_xml_to_table" do
    before {
      @src = File.read(fixture("election_records/al_staterepresentative_madisoncounty_1820_RECORD-XML.xml"))
    }
    subject {
      @text = helper.voting_record_xml_to_table(@src)
      Nokogiri::HTML.parse(@text)
    }
    it "should have a page images header" do
      subject.xpath('//h2[text()="Page Images:"]').size.should == 1 
    end
    it "should have a figure" do
      subject.xpath('//figure/img/@src').first.value.should == "http://repository01.lib.tufts.edu:8080/fedora/get/tufts:MS115.001.DO.11024/bdef:TuftsImage/getMediumRes"
      subject.xpath('//figure/figcaption').first.inner_html.should == "Phil's original notebook pages that were used to compile this election. These notes are considered a draft of the electronic version. Therefore, the numbers may not match. To verifiy numbers you will need to check the original sources cited. Some original source material is available at the American Antiquarian Society (<a href=\"www.americanantiquarian.org\">www.americanantiquarian.org</a>)."
    end
  end
end
