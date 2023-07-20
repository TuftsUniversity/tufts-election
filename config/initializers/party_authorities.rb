# frozen_string_literal: true
# Import the party authority data

require 'net/http'

filename = Rails.root.join('tmp', 'party-authority.xml')

if File.exist?(filename)
  Rails.logger.info "Using existing parties authority: #{filename}"
else
  Rails.logger.error "Party authority file missing, looking for file: #{filename}"
end

# Load the parties
Rails.logger.info "Importing parties from #{filename}"
puts "Importing parties from #{filename}"

namespaces = { 'auth' => 'http://dca.tufts.edu/aas/auth' }

Nokogiri::XML(File.new(filename)).root.xpath('/party-authority-list/auth:party', namespaces).each do |node|
  name = node.attribute('name').value
  id = node.attribute('id').value

  description = node.xpath('./auth:description', namespaces).children.to_s.strip

  party_attrs = { name: name, id: id, description: description }

  Party.register(party_attrs)
end
