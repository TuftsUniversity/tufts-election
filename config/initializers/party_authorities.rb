# Import the party authority data

uri_for_party_file = 'http://dl.tufts.edu/file_assets/generic/tufts:party-authority/0'
filename = Rails.root.join('tmp', 'party-authority.xml')

# Download the party authority file
if (Rails.env.development? || Rails.env.test?) && File.exist?(filename)
  Rails.logger.info "Skipping download, using existing party authority: #{filename}"
  puts "Skipping download, using existing party authority: #{filename}"
else
  require 'open-uri'
  Rails.logger.info "Downloading party authority from #{uri_for_party_file}"
  puts "Downloading party authority from #{uri_for_party_file}"

  File.open(filename, 'w') do |file|
    open uri_for_party_file do |f|
      file.write response.body.force_encoding('UTF-8')
    end
  end
end

# Load the parties
Rails.logger.info "Importing parties from #{filename}"
puts "Importing parties from #{filename}"

namespaces = {'auth' => 'http://dca.tufts.edu/aas/auth'}

Nokogiri::XML(File.new(filename)).root.xpath('/party-authority-list/auth:party', namespaces).each do |node|
  name = node.attribute('name').value
  id =  node.attribute('id').value

  description = node.xpath('./auth:description', namespaces).children.to_s.strip

  party_attrs = { name: name, id: id, description: description }

  Party.register(party_attrs)
end

