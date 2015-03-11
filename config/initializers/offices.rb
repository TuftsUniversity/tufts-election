# Import the offices authority data

offices = Hash.new

uri_for_offices_file = 'http://dl.tufts.edu/file_assets/generic/tufts:MS115.003.001.00003.00001/0'
filename = Rails.root.join('tmp', 'offices.xml')

# Download the offices authority file
if (Rails.env.development? || Rails.env.test?) && File.exist?(filename)
  Rails.logger.info "Skipping download, using existing offices authority: #{filename}"
  puts "Skipping download, using existing offices authority: #{filename}"
else
  require 'open-uri'
  Rails.logger.info "Downloading offices authority from #{uri_for_offices_file}"
  puts "Downloading offices authority from #{uri_for_offices_file}"

  File.open(filename, 'w') do |file|
    open uri_for_offices_file do |f|
      f.each_line {|line| file.write line }
    end
  end
end

# Load the offices
Rails.logger.info "Importing offices from #{filename}"
puts "Importing offices from #{filename}"

input = Nokogiri::XML(File.new(filename))
input.root.xpath('//auth:office', 'auth' => 'http://dca.tufts.edu/aas/auth').each do |office_node|
  name = office_node.attribute('name').value
  id = office_node.attribute('id').value

  office_attrs = { name: name, id: id }
  Office.register(office_attrs)
end
