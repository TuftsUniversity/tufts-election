module VotingRecordHelper

  ##
  # Return the transformed voting record as HTML.
  #
  # @param {str} vr_xml
  #   The xml of this VotingRecord
  # @return {str}
  #   The translated html output.
  def voting_record_xml_to_html(vr_xml)
    src = Nokogiri::XML(vr_xml)
    xslt = Nokogiri::XSLT(File.read("#{::Rails.root}/xslt/viewVotingRecord.xsl"))
    xslt.transform(src).inner_html.to_s.html_safe
  end

  ##
  # Maps an array of urns to the iiif ids.
  #
  # @param {arr} urns
  #   An array of urn strings, like tufts:central:dca:MS115:asf.bla0.2008 .
  # @return {arr}
  #   An array of iiif id strings.
  def urns_to_iiif(urns)
    urns.map do |urn|
      pid = urn.sub!('central:dca:MS115:', '').sub!(':', '\:')
      get_file_id_from_legacy_pid(pid)
    end
  end

  ##
  # Gets the iiif id from a fedora3 pid.
  #
  # @param {str} pid
  #   The old Fedora 3 pid.
  # @return {str}
  #   The iiif id to the current image.
  def get_file_id_from_legacy_pid(pid)
    Image.where(legacy_pid: pid).first.file_sets.first.files.first.id
  end

end
