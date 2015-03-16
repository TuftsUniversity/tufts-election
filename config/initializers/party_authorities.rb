# Import the party authority data

require 'net/http'

uri_for_party_file = URI('http://dl.tufts.edu/file_assets/generic/tufts:party-authority/0')
filename = Rails.root.join('tmp', 'party-authority.xml')

# Download the party authority file
if (Rails.env.development? || Rails.env.test?) && File.exist?(filename)
  Rails.logger.info "Skipping download, using existing party authority: #{filename}"
  puts "Skipping download, using existing party authority: #{filename}"
else
  Rails.logger.info "Downloading party authority from #{uri_for_party_file}"
  puts "Downloading party authority from #{uri_for_party_file}"

  response = Net::HTTP.get_response(uri_for_party_file)

  if response.code == '200'
    File.open(filename, 'w') do |file|
      file.write response.body.force_encoding('UTF-8')
    end
  else
    msg = "Warning: Could not load #{uri_for_party_file} (HTTP response: #{response.code}). Attempting to read local cached copy."

    puts msg
    Rails.logger.warn msg
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

