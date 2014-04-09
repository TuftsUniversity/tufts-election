$offices = Hash.new

filename = Rails.root.join('config','office-authority.xml')

puts "Importing #{filename}"

input = Nokogiri::XML(File.new(filename))
input.root.xpath('//auth:office', 'auth' => 'http://dca.tufts.edu/aas/auth').each do |office_node|

  name = office_node.attribute('name').value
  id =  office_node.attribute('id').value
  $offices[id] = name
end
