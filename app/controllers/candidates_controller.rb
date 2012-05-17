class CandidatesController < CatalogController
  # This filters out objects that you want to exclude from search results, like FileAssets
  CandidatesController.solr_search_params_logic << :exclude_unwanted_models
  
  configure_blacklight do |config|
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 100 
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
    config.add_facet_field 'candidate_last_name_letter_facet', :label => 'Letter' 

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.default_solr_params[:'facet.field'] = config.facet_fields.keys

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display 
    config.add_index_field 'office_name_t', :label => 'Office:' 
    config.add_index_field 'jurisdiction_display', :label => 'Jurisdiction:' 
    config.add_index_field 'date_t', :label => 'Year:' 
    config.add_index_field 'state_name_facet', :label => 'State:' 

    
    config.add_search_field 'all_fields', :label => 'All Fields'
    

    config.add_sort_field 'score desc, date_i asc, title_sort asc', :label => 'relevance'
    config.add_sort_field 'date_i asc, title_sort asc', :label => 'year'
    config.add_sort_field 'title_sort asc, date_i asc', :label => 'title'

    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
  end

  # This filters out objects that you want to exclude from search results.  By default it only excludes FileAssets
  # @param solr_parameters the current solr parameters
  # @param user_parameters the current user-subitted parameters
  def exclude_unwanted_models(solr_parameters, user_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "format:Candidate"
  end

end
