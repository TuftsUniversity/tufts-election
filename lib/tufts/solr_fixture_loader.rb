# frozen_string_literal: true
require 'rsolr'
# @file
# Loads YAML fixtures into Solr

module Tufts
  class SolrFixtureLoader
    ##
    # Loads all fixtures located in solr_fixture_path, into Solr.
    def load_all_fixtures
      files = Dir.glob(solr_fixtures_path)
      files.each do |f|
        doc = YAML.load_file(f)
        load_fixture(doc, false)
      end
      solr.commit
    end

    ##
    # Adds a single document to solr.
    #
    # @param {hash} doc
    #   The document to add.
    # @param {bool} commit_now
    #   Whether to commit immediately or not.
    def load_fixture(doc, commit_now = true)
      solr.add(doc)
      solr.commit if commit_now
    end

    private

    def solr_fixtures_path
      Rails.root.join('spec', 'fixtures', 'election_records', '*.yml')
    end

    def solr
      @solr ||= RSolr.connect(url: Blacklight.blacklight_yml[Rails.env]["url"])
    end
  end
end
