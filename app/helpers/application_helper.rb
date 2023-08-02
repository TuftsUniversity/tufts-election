# frozen_string_literal: true
module ApplicationHelper
  module Blacklight::FacetsHelperBehavior
    # Standard display of a SELECTED facet value (e.g. without a link and with a remove button)
    # @params (see #render_facet_value)
    def render_selected_facet_value(facet_solr_field, item)
      content_tag(:span, class: "facet-label") do
        content_tag(:span, facet_display_value(facet_solr_field, item), class: "selected") + render_facet_count(item.hits) +
          # remove link
          link_to(content_tag(:span, '', class: "glyphicon glyphicon-remove") + content_tag(:span, '[remove]', class: 'sr-only'),
search_action_path(remove_facet_params(facet_solr_field, item, params)), class: "remove")
      end
    end
  end

  def ga_track
    javascript_tag("if(window.ga != undefined){ga('send', 'pageview');}")
  end

  def office_name(id)
    office = Office.find(id)
    office.blank? ? id : office.name
  end

  def party_name(id)
    party = Party.find(id)
    party.blank? ? id : party.name
  end

  def display_facet_details?
    office_facet_selected? || party_facet_selected? || state_facet_selected?
  end

  def office_facet_selected?
    params[:f]&.key?('office_id_ssim')
  end

  def party_facet_selected?
    params[:f]&.key?('party_affiliation_id_ssim')
  end

  def state_facet_selected?
    params[:f]&.key?('state_name_sim')
  end

  def selected_party_facets
    Array(params[:f]['party_affiliation_id_ssim']).each do |facet_value|
      if (party = Party.find(facet_value))
        yield party if block_given?
      end
    end
  end

  def selected_office_facets
    Array(params[:f]['office_id_ssim']).each do |facet_value|
      if (office = Office.find(facet_value))
        yield office if block_given?
      end
    end
  end

  def selected_state_facets
    Array(params[:f]['state_name_sim']).each do |facet_value|
      if (state = State.find(facet_value))
        yield state if block_given?
      end
    end
  end

  def state_thumbnail(name)
    if (abbr = us_states[name])
      image_tag "state_images/#{abbr.downcase}.gif", class: "stateThumbnail", alt: "Map of #{name}", title: "Map of #{name}"
    else
      ''
    end
  end

  def us_states
    {
      'Alabama' => 'AL',
      'Alaska' => 'AK',
      'Arizona' => 'AZ',
      'Arkansas' => 'AR',
      'California' => 'CA',
      'Colorado' => 'CO',
      'Connecticut' => 'CT',
      'Delaware' => 'DE',
      'District of Columbia' => 'DC',
      'Florida' => 'FL',
      'Georgia' => 'GA',
      'Hawaii' => 'HI',
      'Idaho' => 'ID',
      'Illinois' => 'IL',
      'Indiana' => 'IN',
      'Iowa' => 'IA',
      'Kansas' => 'KS',
      'Kentucky' => 'KY',
      'Louisiana' => 'LA',
      'Maine' => 'ME',
      'Maryland' => 'MD',
      'Massachusetts' => 'MA',
      'Michigan' => 'MI',
      'Minnesota' => 'MN',
      'Mississippi' => 'MS',
      'Missouri' => 'MO',
      'Montana' => 'MT',
      'Nebraska' => 'NE',
      'Nevada' => 'NV',
      'New Hampshire' => 'NH',
      'New Jersey' => 'NJ',
      'New Mexico' => 'NM',
      'New York' => 'NY',
      'North Carolina' => 'NC',
      'North Dakota' => 'ND',
      'Ohio' => 'OH',
      'Oklahoma' => 'OK',
      'Oregon' => 'OR',
      'Pennsylvania' => 'PA',
      'Puerto Rico' => 'PR',
      'Rhode Island' => 'RI',
      'South Carolina' => 'SC',
      'South Dakota' => 'SD',
      'Tennessee' => 'TN',
      'Texas' => 'TX',
      'Utah' => 'UT',
      'Vermont' => 'VT',
      'Virginia' => 'VA',
      'Washington' => 'WA',
      'West Virginia' => 'WV',
      'Wisconsin' => 'WI',
      'Wyoming' => 'WY'
    }
  end
end
