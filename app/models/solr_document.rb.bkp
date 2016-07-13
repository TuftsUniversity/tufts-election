# -*- encoding : utf-8 -*-
class SolrDocument 

  include Blacklight::Solr::Document

  # self.unique_key = 'id'
  
  # The following shows how to setup this blacklight document to display marc documents
  extension_parameters[:marc_source_field] = :marc_display
  extension_parameters[:marc_format_type] = :marcxml
  # Add the blacklight-marc gem to your Gemfile. If you are not using MARC-flavor metadata, 
  # you can omit them gem, and remove any references to Blacklight::Solr::Document::Marc
  # from your SolrDocument class.
  #use_extension( Blacklight::Solr::Document::Marc) do |document|
  #  document.key?( :marc_display  )
  #end
  
  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension( Blacklight::Solr::Document::Email )
  
  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension( Blacklight::Solr::Document::Sms )

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Solr::Document::ExtendableClassMethods#field_semantics
  # and Blacklight::Solr::Document#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension( Blacklight::Solr::Document::DublinCore)    
  field_semantics.merge!(    
                         :title => "title_tesi",
                         :author => "author_tesim",
                         :language => "language_ssim",
                         :format => "format_ssim"
                         )
end
