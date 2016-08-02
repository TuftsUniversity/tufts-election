require 'rails_helper'

describe ApplicationHelper do

  describe '#office_name' do
    let(:clerk)  {{ id: "ON016", name: "Clerk" }}
    before { Office.register(clerk) }

    it 'returns the name of the office' do
      expect(helper.office_name(clerk[:id])).to eq clerk[:name]
    end

    it 'returns the input id if the office is not found' do
      expect(helper.office_name('unknown id')).to eq 'unknown id'
    end
  end

end
