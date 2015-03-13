# Import candidate names authority

require 'net/http'
uri_for_candidates_file = URI('http://dl.tufts.edu/file_assets/generic/tufts:MS115.003.001.00002.00001/0')

filename = Rails.root.join('tmp', 'candidates.xml')

if (Rails.env.development? || Rails.env.test?) && File.exist?(filename)
  Rails.logger.info 'Skipping load candidate names authority'
  puts 'Skipping load candidate names authority'
else
  # Download the candidate names authority file
  Rails.logger.info "Downloading candidate names authority from #{uri_for_candidates_file}"
  puts "Downloading candidate names authority from #{uri_for_candidates_file}"

  response = Net::HTTP.get_response(uri_for_candidates_file)

  if response.code == '200'
    File.open(filename, 'w') do |file|
      file.write response.body
    end
  else
    msg = "Warning: Could not load #{uri_for_candidates_file} (HTTP response: #{response.code}). Attempting to read local cached copy."

    puts msg
    Rails.logger.warn msg
  end
end

# Import the candidate names
Rails.logger.info "Importing candidate names authority from #{filename}"
puts "Importing candidate names authority from #{filename}"

input = Nokogiri::XML(File.new("#{filename}"))
docs = []
input.root.xpath('//auth:candidate', 'auth' => 'http://dca.tufts.edu/aas/auth').each do |candidate_node|
  name = candidate_node.attribute('name').value
  docs << { 'name_tesim' => name, 'title_tesim' => name, 'title_ssi' => name, 'title_tesim' => name, 'candidate_last_name_letter_sim' => name.first.upcase, 'id' => candidate_node.attribute('id').value, 'format_ssim' => 'Candidate', 'all_text_timv' => name }
end

ActiveFedora::SolrService.instance.conn.add(docs)
ActiveFedora::SolrService.commit

