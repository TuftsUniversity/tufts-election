# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController  

  include Blacklight::Catalog
  
  # This filters out objects that you want to exclude from search results, like FileAssets
  CatalogController.solr_search_params_logic += [:exclude_unwanted_models, :exclude_drafts]
  before_filter :enforce_show_permissions, :only=>:show

  configure_blacklight do |config|
    config.default_solr_params = { 
      :qt => 'search',
      :rows => 10,
    }

    # solr field configuration for search results/index views
    config.index.title_field = 'title_tesim'
    config.index.display_type_field  = 'format_ssim'

    # solr field configuration for document/show views
    config.show.title_field  = 'title_tesim'
    #config.show.heading = 'title_display'
    config.show.display_type_field  = 'format_ssim'

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
    config.add_facet_field 'state_name_sim', :label => 'State', :sort => 'index', :limit => 50
    config.add_facet_field 'date_sim', :label => 'Year', :range => true, :sort => 'index'
    config.add_facet_field 'office_id_ssim', :label => 'Office', :limit => 20, helper_method: :office_name
    config.add_facet_field 'jurisdiction_sim', :label => 'Jurisdiction', :limit => 15
    config.add_facet_field 'party_affiliation_id_ssim', :label => 'Party', :limit => 15, helper_method: :party_name
    config.add_facet_field 'election_type_sim', :label => 'Election Type'
    config.add_facet_fields_to_solr_request!

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.default_solr_params[:'facet.field'] = config.facet_fields.keys

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field 'office_name_tesim', :label => 'Office'
    config.add_index_field 'jurisdiction_tesim', :label => 'Jurisdiction'
    config.add_index_field 'date_tesim', :label => 'Year'
    config.add_index_field 'state_name_tesim', :label => 'State'
    config.add_index_field 'party_affiliation_sim', :label => 'Party Affiliation'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display 
    # config.add_show_field 'title_vern_display', :label => 'Title:' 
    # config.add_show_field 'subtitle_display', :label => 'Subtitle:' 
    # config.add_show_field 'subtitle_vern_display', :label => 'Subtitle:' 
    # config.add_show_field 'author_display', :label => 'Author:' 
    # config.add_show_field 'author_vern_display', :label => 'Author:' 
    # config.add_show_field 'url_fulltext_display', :label => 'URL:'
    # config.add_show_field 'url_suppl_display', :label => 'More Information:'
    # config.add_show_field 'language_facet', :label => 'Language:'
    # config.add_show_field 'published_display', :label => 'Published:'
    # config.add_show_field 'published_vern_display', :label => 'Published:'
    # config.add_show_field 'lc_callnum_display', :label => 'Call number:'
    # config.add_show_field 'isbn_t', :label => 'ISBN:'

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

    config.add_search_field('Candidate') do |field|
      field.solr_local_parameters = { 
        :qf => 'name_tesim',
        :pf => 'name_tesim',
      }
    end

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
    config.add_sort_field 'score desc, date_isi asc, title_ssi asc', :label => 'relevance'
    config.add_sort_field 'date_isi asc, title_ssi asc', :label => 'year'
    config.add_sort_field 'title_ssi asc, date_isi asc', :label => 'title'

    # If there are more than this many search results, no spelling ("did you 
    # mean") suggestion is offered.
    config.spell_max = 5
  end

  # This filters out objects that you want to exclude from search results.  By default it only excludes FileAssets
  # @param solr_parameters the current solr parameters
  # @param user_parameters the current user-subitted parameters
  def exclude_unwanted_models(solr_parameters, user_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "has_model_ssim:\"info:fedora/cm:VotingRecord\" OR format_ssim:Candidate"
  end

  def exclude_drafts(solr_parameters,user_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "-id:draft*"
  end

  def enforce_show_permissions(opts={})
    id = params[:id]
    unless id.nil?
      if (id[/^draft/])
        flash[:alert] = "Draft objects are not available."
        redirect_to(:action=>'index', :q=>nil, :f=>nil) and return false
      end
    end
  end

end 
