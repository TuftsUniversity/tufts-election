module ApplicationHelper
  module Blacklight::FacetsHelperBehavior

  # Standard display of a SELECTED facet value (e.g. without a link and with a remove button)
    # @params (see #render_facet_value)
    def render_selected_facet_value(facet_solr_field, item)
      content_tag(:span, :class => "facet-label") do
        content_tag(:span, facet_display_value(facet_solr_field, item), :class => "selected") + render_facet_count(item.hits) +
        # remove link
        link_to(content_tag(:span, '', :class => "glyphicon glyphicon-remove") + content_tag(:span, '[remove]', :class => 'sr-only'), search_action_path(remove_facet_params(facet_solr_field, item, params)), :class=>"remove")
      end
    end
  end

  def display_facet_details?
    office_facet_selected? || party_facet_selected? || state_facet_selected?
  end

  def office_facet_selected?
    params[:f] && params[:f].key?('office_name_sim')
  end

  def party_facet_selected?
    params[:f] && params[:f].key?('party_affiliation_sim')
  end

  def state_facet_selected?
    params[:f] && params[:f].key?('state_name_tesim')
  end

  def selected_party_facets
    params[:f]['party_affiliation_sim'].each do |facet_value|
      if party = Party.find(facet_value)
        yield party if block_given?
      end
    end
  end

  def selected_office_facets
    params[:f]['office_name_sim'].each do |facet_value|
      if office = Office.find(facet_value)
        yield office if block_given?
      end
    end
  end

  def selected_state_facets
    params[:f]['state_name_tesim'].each do |facet_value|
      if state = State.find(facet_value)
        yield state if block_given?
      end
    end
  end

end
