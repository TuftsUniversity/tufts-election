# frozen_string_literal: true
# Import the offices authority data

require 'net/http'

filename = Rails.root.join('tmp', 'offices.xml')

if File.exist?(filename)
  Rails.logger.info "Using existing offices authority: #{filename}"
else
  Rails.logger.error "Office authority file missing, looking for file: #{filename}"
end

# Load the offices
Rails.logger.info "Importing offices from #{filename}"

input = Nokogiri::XML(File.new(filename))
namespaces = { 'auth' => 'http://dca.tufts.edu/aas/auth' }

input.root.xpath('//auth:office', namespaces).each do |office_node|
  office_node.xpath('//xref:office').each do |xref|
    xref.namespace = nil
    xref.name = 'a'
    xref['href'] = "/catalog?f%5Boffice_id_ssim%5D%5B%5D=#{xref['id']}"
  end

  name = office_node.attribute('name').value
  id = office_node.attribute('id').value
  desc = office_node.xpath('./auth:description', namespaces).children.to_s.strip

  office_attrs = { name: name, id: id, description: desc }
  Office.register(office_attrs)
end
