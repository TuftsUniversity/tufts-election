# frozen_string_literal: true
module VotingRecordHelper
  ##
  # Return the transformed voting record as HTML.
  #
  # @param {str} vr_xml
  #   The xml of this VotingRecord
  # @return {str}
  #   The translated html output.
  # rubocop:disable Rails/OutputSafety
  def voting_record_xml_to_html(vr_xml)
    src = Nokogiri::XML(vr_xml)
    xslt = Nokogiri::XSLT(File.read("#{::Rails.root}/xslt/viewVotingRecord.xsl"))
    xslt.transform(src).inner_html.to_s.html_safe
  end
end
