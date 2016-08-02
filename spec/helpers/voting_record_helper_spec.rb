require 'rails_helper'

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
      expect(subject.xpath('//h2[text()="Page Images:"]').size).to eq(1) 
    end
    it "should link to the candidates" do
      expect(subject.xpath('//tr[@class="candidate-row"]/th/a/@href').first.value).to eq(catalog_path("VJ0000"))
    end
    it "should have a figure" do
      expect(subject.xpath('//figure/img/@src').first.value).to eq("http://dl.tufts.edu/file_assets/tufts:MS115.001.DO.11024")
      expect(subject.xpath('//figure/figcaption').first.inner_html).to eq("Phil's original notebook pages that were used to compile this election. These notes are considered a draft of the electronic version. Therefore, the numbers may not match. To verify numbers you will need to check the original sources cited. Some original source material is available at the <a href=\"http://www.americanantiquarian.org\">American Antiquarian Society</a>).")
    end
  end
end
