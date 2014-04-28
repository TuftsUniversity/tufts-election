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
end
