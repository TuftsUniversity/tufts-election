# Import the state authority data

require 'net/http'
uri_for_state_file = 'http://dl.tufts.edu/file_assets/generic/tufts:state-authority/0'

filename = Rails.root.join('tmp', 'state-authorities.xml')

if (Rails.env.development? || Rails.env.test?) && File.exist?(filename)
  Rails.logger.info "Skipping download, using existing state authority: #{filename}"
  puts "Skipping download, using existing state authority: #{filename}"
else
  Rails.logger.info "Downloading state authority from #{uri_for_state_file}"
  puts "Downloading state authority from #{uri_for_state_file}"

  response = Net::HTTP.get_response(URI(uri_for_state_file))

  if response.code == '200'
    File.open(filename, 'w') do |file|
      file.write response.body.force_encoding('UTF-8')
    end
  else
    msg = "Warning: Could not load #{uri_for_state_file} (HTTP response: #{response.code}). Attempting to read local cached copy."

    puts msg
    Rails.logger.warn msg
  end
end

# Load the states
Rails.logger.info "Importing states from #{filename}"
puts "Importing states from #{filename}"

namespaces = { 'xhtml' => 'http://www.w3.org/1999/xhtml' }

Nokogiri::XML(File.new(filename)).root.xpath('//xhtml:authority', namespaces).each do |node|
  name = node.attribute('state').value

  history = node.xpath('./xhtml:history', namespaces).children.to_s.strip
  bibliography = node.xpath('./xhtml:bibliography', namespaces).children.to_s.strip

  State.register(name: name, history: history, bibliography: bibliography)
end


