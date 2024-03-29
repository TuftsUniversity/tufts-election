# frozen_string_literal: true
class CatalogController < ApplicationController
  include BlacklightRangeLimit::ControllerOverride

  include Blacklight::Catalog

  include Blacklight::DefaultComponentConfiguration
  include CandidateHelper
  helper_method :related_elections

  # rubocop:disable Security/Eval
  def show
    if params[:id].start_with?('tufts') && Rails.env.production?
      h = Net::HTTP.new('tdrsearch-prod-01.uit.tufts.edu', 8983)
      http_response = h.get("/solr/mira_prod/select?fl=id&indent=on&q=legacy_pid_tesim:\"#{params[:id]}\"&wt=ruby")
      rsp = eval(http_response.body)
      params[:id] = rsp['response']['docs'][0]['id'] if rsp['response']['docs'].present?
    end
    super
  end

  # rubocop:disable Rails/I18nLocaleTexts
  configure_blacklight do |config|
    ## Class for sending and receiving requests from a search index
    # config.repository_class = Blacklight::Solr::Repository
    #
    ## Class for converting Blacklight's url parameters to into request parameters for the search index
    # config.search_builder_class = ::SearchBuilder
    #
    ## Model that maps search index responses to the blacklight response model
    # config.response_model = Blacklight::Solr::Response

    before_action :enforce_show_permissions, only: :show

    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      qt: 'search'
    }

    config.default_per_page = 10

    # solr path which will be added to solr base url before the other solr params.
    # config.solr_path = 'select'

    # items to show per page, each number in the array represent another option to choose from.
    # config.per_page = [10,20,50,100]

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SearchHelper#solr_doc_params) or
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    # config.default_document_solr_params = {
    #  qt: 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # fl: '*',
    #  # rows: 1,
    #  # q: '{!term f=id v=$id}'
    # }

    # solr field configuration for search results/index views
    config.index.title_field = 'title_tesim'
    config.index.display_type_field = 'format_ssim'

    # solr field configuration for document/show views
    # config.show.title_field = 'title_display'
    config.show.title_field = 'title_tesim'
    # config.show.display_type_field = 'format'
    config.show.display_type_field = 'format_ssim'

    # new for blacklight 7
    config.add_results_collection_tool(:sort_widget)
    config.add_results_collection_tool(:per_page_widget)
    config.add_results_collection_tool(:view_type_group)

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
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar
    #
    # set :index_range to true if you want the facet pagination view to have facet prefix-based navigation
    #  (useful when user clicks "more" on a large facet and wants to navigate alphabetically across a large set of results)
    # :index_range can be an array or range of prefixes that will be used to create the navigation (note: It is case sensitive when searching values)

    # Original facets
    # config.add_facet_field 'format', label: 'Format'
    # config.add_facet_field 'pub_date', label: 'Publication Year', single: true
    # config.add_facet_field 'subject_topic_facet', label: 'Topic', limit: 20, index_range: 'A'..'Z'
    # config.add_facet_field 'language_facet', label: 'Language', limit: true
    # config.add_facet_field 'lc_1letter_facet', label: 'Call Number'
    # config.add_facet_field 'subject_geo_facet', label: 'Region'
    # config.add_facet_field 'subject_era_facet', label: 'Era'

    # config.add_facet_field 'example_pivot_field', label: 'Pivot Field', :pivot => ['format', 'language_facet']

    # config.add_facet_field 'example_query_facet_field', label: 'Publish Date', :query => {
    #   :years_5 => { label: 'within 5 Years', fq: "pub_date:[#{Time.zone.now.year - 5 } TO *]" },
    #   :years_10 => { label: 'within 10 Years', fq: "pub_date:[#{Time.zone.now.year - 10 } TO *]" },
    #   :years_25 => { label: 'within 25 Years', fq: "pub_date:[#{Time.zone.now.year - 25 } TO *]" }
    # }
    config.add_facet_field 'state_name_sim', label: 'State', sort: 'index', limit: 50
    # config.add_facet_field 'date_sim', :label => 'Year', :range => true, :sort => 'index'
    config.add_facet_field 'pub_date_facet_isim', label: 'Year', range: true, sort: 'index'
    config.add_facet_field 'office_id_ssim', label: 'Office', limit: 20, helper_method: :office_name
    config.add_facet_field 'jurisdiction_sim', label: 'Jurisdiction', limit: 15
    config.add_facet_field 'party_affiliation_id_ssim', label: 'Party', limit: 15, helper_method: :party_name
    config.add_facet_field 'election_type_sim', label: 'Election Type'

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    # Original index fields
    # config.add_index_field 'title_display', label: 'Title'
    # config.add_index_field 'title_vern_display', label: 'Title'
    # config.add_index_field 'author_display', label: 'Author'
    # config.add_index_field 'author_vern_display', label: 'Author'
    # config.add_index_field 'format', label: 'Format'
    # config.add_index_field 'language_facet', label: 'Language'
    # config.add_index_field 'published_display', label: 'Published'
    # config.add_index_field 'published_vern_display', label: 'Published'
    # config.add_index_field 'lc_callnum_display', label: 'Call number'
    config.add_index_field 'office_name_tesim', label: 'Office'
    config.add_index_field 'jurisdiction_tesim', label: 'Jurisdiction'
    config.add_index_field 'date_tesim', label: 'Year'
    config.add_index_field 'state_name_tesim', label: 'State'
    config.add_index_field 'party_affiliation_sim', label: 'Party Affiliation'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    # config.add_show_field 'title_display', label: 'Title'
    # config.add_show_field 'title_vern_display', label: 'Title'
    # config.add_show_field 'subtitle_display', label: 'Subtitle'
    # config.add_show_field 'subtitle_vern_display', label: 'Subtitle'
    # config.add_show_field 'author_display', label: 'Author'
    # config.add_show_field 'author_vern_display', label: 'Author'
    # config.add_show_field 'format', label: 'Format'
    # config.add_show_field 'url_fulltext_display', label: 'URL'
    # config.add_show_field 'url_suppl_display', label: 'More Information'
    # config.add_show_field 'language_facet', label: 'Language'
    # config.add_show_field 'published_display', label: 'Published'
    # config.add_show_field 'published_vern_display', label: 'Published'
    # config.add_show_field 'lc_callnum_display', label: 'Call number'
    # config.add_show_field 'isbn_t', label: 'ISBN'

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

    config.add_search_field 'all_fields', label: 'All Fields'

    config.add_search_field('Candidate') do |field|
      field.solr_local_parameters = {
        qf: 'name_tesim',
        pf: 'name_tesim'
      }
    end

    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    # config.add_search_field('title') do |field|
    #  # solr_parameters hash are sent to Solr as ordinary url query params.
    #  field.solr_parameters = { :'spellcheck.dictionary' => 'title' }

    #  # :solr_local_parameters will be sent using Solr LocalParams
    #  # syntax, as eg {! qf=$title_qf }. This is neccesary to use
    #  # Solr parameter de-referencing like $title_qf.
    #  # See: http://wiki.apache.org/solr/LocalParams
    #  field.solr_local_parameters = {
    #    qf: '$title_qf',
    #    pf: '$title_pf'
    #  }
    # end

    # config.add_search_field('author') do |field|
    #  field.solr_parameters = { :'spellcheck.dictionary' => 'author' }
    #  field.solr_local_parameters = {
    #    qf: '$author_qf',
    #    pf: '$author_pf'
    #  }
    # end

    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as
    # config[:default_solr_parameters][:qt], so isn't actually neccesary.
    # config.add_search_field('subject') do |field|
    #  field.solr_parameters = { :'spellcheck.dictionary' => 'subject' }
    #  field.qt = 'search'
    #  field.solr_local_parameters = {
    #    qf: '$subject_qf',
    #    pf: '$subject_pf'
    #  }
    # end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    # Original sort_fields
    # config.add_sort_field 'score desc, pub_date_sort desc, title_sort asc', label: 'relevance'
    # config.add_sort_field 'pub_date_sort desc, title_sort asc', label: 'year'
    # config.add_sort_field 'author_sort asc, title_sort asc', label: 'author'
    # config.add_sort_field 'title_sort asc, pub_date_sort desc', label: 'title'
    config.add_sort_field 'score desc, date_isi asc, title_ssi asc', label: 'relevance'
    config.add_sort_field 'date_isi asc, title_ssi asc', label: 'year'
    config.add_sort_field 'title_ssi asc, date_isi asc', label: 'title'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5

    # Configuration for autocomplete suggestor
    config.autocomplete_enabled = true
    config.autocomplete_path = 'suggest'

    # rubocop:disable Metrics/MethodLength
    def enforce_show_permissions(_opts = {})
      id = params[:id]
      return if id.nil?
      return unless id[/^draft/]
      flash[:alert] = "Draft objects are not available."
      redirect_to(action: 'index', q: nil, f: nil) and return false
    end

    # new blacklight configure for version 7
    config.add_results_document_tool(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)

    # config.add_results_collection_tool(:sort_widget)
    # config.add_results_collection_tool(:per_page_widget)
    # config.add_results_collection_tool(:view_type_group)

    config.add_show_tools_partial(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)
    config.add_show_tools_partial(:email, callback: :email_action, validator: :validate_email_params)
    config.add_show_tools_partial(:sms, if: :render_sms_action?, callback: :sms_action, validator: :validate_sms_params)
    config.add_show_tools_partial(:citation)

    config.add_nav_action(:bookmark, partial: 'blacklight/nav/bookmark', if: :render_bookmarks_control?)
    config.add_nav_action(:search_history, partial: 'blacklight/nav/search_history')
  end

  # Handles errors when ids have been removed by returning a 404 page
  rescue_from Blacklight::Exceptions::RecordNotFound, with: -> { render status: :not_found, layout: false, template: 'errors/not_found' }
end
