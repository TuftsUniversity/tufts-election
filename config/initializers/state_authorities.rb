# frozen_string_literal: true
# Import the state authority data

require 'net/http'
require_dependency Rails.root.join('app', 'models', 'state.rb')

filename = Rails.root.join('tmp', 'state-authorities.xml')

if File.exist?(filename)
  Rails.logger.info "Using existing states authority: #{filename}"
else
  Rails.logger.error "State authority file missing, looking for file: #{filename}"
end

# Load the states
Rails.logger.info "Importing states from #{filename}"

namespaces = { 'xhtml' => 'http://www.w3.org/1999/xhtml' }

Nokogiri::XML(File.new(filename)).root.xpath('//xhtml:authority', namespaces).each do |node|
  name = node.attribute('state').value

  history = node.xpath('./xhtml:history', namespaces).children.to_s.strip
  bibliography = node.xpath('./xhtml:bibliography', namespaces).children.to_s.strip

  State.register(name: name, history: history, bibliography: bibliography)
end
