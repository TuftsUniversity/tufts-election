# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController  

  include Blacklight::Catalog

  configure_blacklight do |config|
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 10 
    }

    # solr field configuration for search results/index views
    config.index.show_link = 'title_display'
    config.index.record_display_type = 'format'

    # solr field configuration for document/show views
    config.show.html_title = 'title_display'
    config.show.heading = 'title_display'
    config.show.display_type = 'format'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.    
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or 
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.  
    config.add_facet_field 'format', :label => 'Format' 
    config.add_facet_field 'state_name_facet', :label => 'State' 
    config.add_facet_field 'date_i', :label => 'Year', :range=>true
    config.add_facet_field 'office_name_facet', :label => 'Office', :limit => 20 
    config.add_facet_field 'office_role_title_facet', :label => 'Position/Title', :limit => 20 
    config.add_facet_field 'candidate_name_facet', :label => 'Candidate', :limit => 15 
    config.add_facet_field 'party_affiliation_facet', :label => 'Party', :limit => 15 
    config.add_facet_field 'election_type_facet', :label => 'Election Type'  

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.default_solr_params[:'facet.field'] = config.facet_fields.keys

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display 
    config.add_index_field 'office_name_t', :label => 'Office:' 
    config.add_index_field 'office_role_title_t', :label => 'Title:' 
    config.add_index_field 'jurisdiction_display', :label => 'Jurisdiction:' 
    config.add_index_field 'date_t', :label => 'Year:' 
    config.add_index_field 'state_name_facet', :label => 'State:' 

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display 
    config.add_show_field 'title_vern_display', :label => 'Title:' 
    config.add_show_field 'subtitle_display', :label => 'Subtitle:' 
    config.add_show_field 'subtitle_vern_display', :label => 'Subtitle:' 
    config.add_show_field 'author_display', :label => 'Author:' 
    config.add_show_field 'author_vern_display', :label => 'Author:' 
    config.add_show_field 'url_fulltext_display', :label => 'URL:'
    config.add_show_field 'url_suppl_display', :label => 'More Information:'
    config.add_show_field 'language_facet', :label => 'Language:'
    config.add_show_field 'published_display', :label => 'Published:'
    config.add_show_field 'published_vern_display', :label => 'Published:'
    config.add_show_field 'lc_callnum_display', :label => 'Call number:'
    config.add_show_field 'isbn_t', :label => 'ISBN:'

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different. 

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise. 
    
    config.add_search_field 'all_fields', :label => 'All Fields'
    

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields. 
    # 
    # config.add_search_field('title') do |field|
    #   # solr_parameters hash are sent to Solr as ordinary url query params. 
    #   field.solr_parameters = { :'spellcheck.dictionary' => 'title' }

    #   # :solr_local_parameters will be sent using Solr LocalParams
    #   # syntax, as eg {! qf=$title_qf }. This is neccesary to use
    #   # Solr parameter de-referencing like $title_qf.
    #   # See: http://wiki.apache.org/solr/LocalParams
    #   field.solr_local_parameters = { 
    #     :qf => '$title_qf',
    #     :pf => '$title_pf'
    #   }
    # end
    # 
    # config.add_search_field('author') do |field|
    #   field.solr_parameters = { :'spellcheck.dictionary' => 'author' }
    #   field.solr_local_parameters = { 
    #     :qf => '$author_qf',
    #     :pf => '$author_pf'
    #   }
    # end
    # 
    # # Specifying a :qt only to show it's possible, and so our internal automated
    # # tests can test it. In this case it's the same as 
    # # config[:default_solr_parameters][:qt], so isn't actually neccesary. 
    # config.add_search_field('subject') do |field|
    #   field.solr_parameters = { :'spellcheck.dictionary' => 'subject' }
    #   field.qt = 'search'
    #   field.solr_local_parameters = { 
    #     :qf => '$subject_qf',
    #     :pf => '$subject_pf'
    #   }
    # end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, year_i desc, title_sort asc', :label => 'relevance'
    config.add_sort_field 'year_i desc, title_sort asc', :label => 'year'
    config.add_sort_field 'author_sort asc, title_sort asc', :label => 'author'
    config.add_sort_field 'title_sort asc, year_i desc', :label => 'title'

    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
  end



end 
