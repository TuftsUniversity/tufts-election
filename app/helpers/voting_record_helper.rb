module VotingRecordHelper

  # Return the compiled voting record XSLT
  def stylesheet
    @bar ||= Nokogiri::XSLT(File.read("#{::Rails.root}/xslt/viewVotingRecord.xsl"))
  end

  # Return the transformed voting record as HTML
  def voting_record_xml_to_table(voting_record_xml)
    src = Nokogiri::XML(voting_record_xml)
    xslt = stylesheet
    xslt.transform(src)
  end
end
