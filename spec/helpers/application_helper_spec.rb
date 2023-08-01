# frozen_string_literal: true
require 'rails_helper'

describe ApplicationHelper do
  describe '#office_name' do
    let(:clerk) { { id: "ON016", name: "Clerk" } }
    before { Office.register(clerk) }

    it 'returns the name of the office' do
      expect(helper.office_name(clerk[:id])).to eq clerk[:name]
    end

    it 'returns the input id if the office is not found' do
      expect(helper.office_name('unknown id')).to eq 'unknown id'
    end
  end

  describe '#party_name' do
    let(:party) { { id: 'A123', name: 'Foo party'} }
    before { Party.register(party) }

    it 'returns the name of the office' do
      expect(helper.party_name(party[:id])).to eq party[:name]
    end

    it 'returns the input id if the office is not found' do
      expect(helper.party_name('unknown id')).to eq 'unknown id'
    end
  end

  describe '#state_thumbnail' do
    it 'return empty if it is not given a known state' do
      expect(helper.state_thumbnail('Ireland')).to eq ''
    end

    it 'returns an image tag' do
      alaska_image_tag = helper.state_thumbnail('Alaska')
      expect(alaska_image_tag).to include 'Alaska'
      expect(alaska_image_tag).to include '.gif'
    end
  end

  describe '#us_states' do
    it 'has all 50 states' do
      expect(helper.us_states.length()).to be >= 50
    end
  end
end
