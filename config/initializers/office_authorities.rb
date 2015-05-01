# Import the offices authority data

require 'net/http'
uri_for_offices_file = 'http://dl.tufts.edu/file_assets/generic/tufts:MS115.003.001.00003.00001/0'

filename = Rails.root.join('tmp', 'offices.xml')

if (Rails.env.development? || Rails.env.test?) && File.exist?(filename)
  Rails.logger.info "Skipping download, using existing offices authority: #{filename}"
  puts "Skipping download, using existing offices authority: #{filename}"
else
  # Download the offices authority file
  Rails.logger.info "Downloading offices authority from #{uri_for_offices_file}"
  puts "Downloading offices authority from #{uri_for_offices_file}"

  response = Net::HTTP.get_response(URI(uri_for_offices_file))

  if response.code == '200'
    File.open(filename, 'w') do |file|
      file.write response.body.force_encoding('UTF-8')
    end
  else
    msg = "Warning: Could not load #{uri_for_offices_file} (HTTP response: #{response.code}). Attempting to read local cached copy."

    puts msg
    Rails.logger.warn msg
  end

end

# Load the offices
Rails.logger.info "Importing offices from #{filename}"
puts "Importing offices from #{filename}"

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

